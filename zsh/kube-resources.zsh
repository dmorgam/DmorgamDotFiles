#!/bin/zsh

#
# kube-resources [namespace]: resources por pod y resumen del namespace.
# Requiere kubectl y jq. CPU en millicores, memoria en Mi.
#

(( $+commands[kubectl] && $+commands[jq] )) || return 0

_KUBE_RESOURCES_JQ='
def cpu: tostring | if endswith("m") then .[:-1] | tonumber else tonumber * 1000 end;
def mem: tostring | capture("^(?<n>[0-9.]+)(?<u>[A-Za-z]*)$") as $c
  | ($c.n | tonumber) * ({"Ki":1024,"Mi":1048576,"Gi":1073741824,"Ti":1099511627776,
      "k":1000,"K":1000,"M":1000000,"G":1000000000}[$c.u] // 1);
def mi: . / 1048576 | round;
def sumc($sec; $res; conv): [.spec.containers[] | (.resources[$sec][$res]? // empty) | conv] | add // 0;
def lim($v): if $v == 0 then "-" else ($v | tostring) end;

($top | split("\n") | map(select(length > 0) | [splits(" +")] | select(length > 2)
  | {(.[0]): {c: (.[1] | cpu), m: (.[2] | mem | mi)}}) | add // {}) as $use

| [.items[] | select(.kind == "Pod")
    | {name: .metadata.name,
       status: (([.status.containerStatuses[]?.state.waiting.reason // empty] | first) // .status.phase),
       ready: "\([.status.containerStatuses[]? | select(.ready)] | length)/\(.spec.containers | length)",
       restarts: ([.status.containerStatuses[]?.restartCount] | add // 0),
       cr: sumc("requests"; "cpu"; cpu), cl: sumc("limits"; "cpu"; cpu),
       mr: (sumc("requests"; "memory"; mem) | mi), ml: (sumc("limits"; "memory"; mem) | mi)}] as $pods

| [.items[] | select(.kind | IN("Deployment", "StatefulSet", "DaemonSet"))
    | (.spec.replicas // .status.desiredNumberScheduled // 0) as $n
    | {kind: .kind, name: .metadata.name, n: $n,
       ready: (.status.readyReplicas // .status.numberReady // 0),
       cr: ($n * (.spec.template | sumc("requests"; "cpu"; cpu))),
       mr: ($n * (.spec.template | sumc("requests"; "memory"; mem)) | mi)}] as $wl

| if $sec == "pods" then
  (["POD", "STATUS", "READY", "RESTARTS", "CPU-USE", "CPU-REQ", "CPU-LIM", "MEM-USE", "MEM-REQ", "MEM-LIM"] | @tsv),
  ($pods[] | [.name, .status, .ready, .restarts,
      (($use[.name].c // null) | if . == null then "-" else "\(.)m" end),
      "\(.cr)m", (lim(.cl) | if . == "-" then . else "\(.)m" end),
      (($use[.name].m // null) | if . == null then "-" else "\(.)Mi" end),
      "\(.mr)Mi", (lim(.ml) | if . == "-" then . else "\(.)Mi" end)] | @tsv)
elif $sec == "wl" then
  (["KIND", "NAME", "READY/DESIRED", "CPU-REQ", "MEM-REQ"] | @tsv),
  ($wl[] | [.kind, .name, "\(.ready)/\(.n)", "\(.cr)m", "\(.mr)Mi"] | @tsv)
else
  (["PODS", "REPLICAS", "CPU-REQ", "CPU-LIM", "MEM-REQ", "MEM-LIM"] | @tsv),
  ([($pods | length), ($wl | map(.n) | add // 0),
    "\($pods | map(.cr) | add // 0)m", "\($pods | map(.cl) | add // 0)m",
    "\($pods | map(.mr) | add // 0)Mi", "\($pods | map(.ml) | add // 0)Mi"] | @tsv)
end
'

kube-resources () {
  local ns=${1:-$(kubectl config view --minify -o jsonpath='{..namespace}')}
  ns=${ns:-default}

  local json top
  json=$(kubectl get pods,deployments,statefulsets,daemonsets -n "$ns" -o json) || return 1
  top=$(kubectl top pods -n "$ns" --no-headers 2> /dev/null)

  local b= c= r=
  [[ -t 1 ]] && { b=$'\e[1m'; c=$'\e[1;36m'; r=$'\e[0m' }

  printf '%sNamespace:%s %s%s%s\n' "$b" "$r" "$c" "$ns" "$r"
  local sec title
  for sec title in pods PODS wl "WORKLOADS (requests = replicas x request por pod)" total TOTAL
  do
    printf '\n%s%s%s\n' "$c" "$title" "$r"
    jq -r --arg top "$top" --arg sec "$sec" "$_KUBE_RESOURCES_JQ" <<< "$json" |
      column -t -s $'\t' |
      awk -v b="$b" -v r="$r" -v pods=$([[ $sec == pods ]] && echo 1 || echo 0) '
        NR == 1 { print b $0 r; next }
        pods && b != "" {
          s = $2
          col = "\033[31m"
          if (s ~ /^(Running|Completed|Succeeded)$/) col = "\033[32m"
          else if (s ~ /^(Pending|ContainerCreating|PodInitializing|Terminating|Init:.*)$/) col = "\033[33m"
          i = length($1) + index(substr($0, length($1) + 1), s)
          $0 = substr($0, 1, i - 1) col s r substr($0, i + length(s))
        }
        { print }'
  done
}

(( $+functions[compdef] )) && compdef '_kube_ns_complete' kube-resources 2> /dev/null
_kube_ns_complete () {
  local -a ns
  ns=(${(f)"$(kubectl get ns -o name 2> /dev/null | sed 's|.*/||')"})
  compadd -a ns
}
