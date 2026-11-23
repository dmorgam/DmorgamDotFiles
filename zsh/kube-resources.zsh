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

| def pct($u; $l): if $u != null and $l > 0 then ($u * 100 / $l | round) else null end;
  def tok($p): if $p == null then "---" else ("000" + ([$p, 999] | min | tostring))[-3:] end;
  if $sec == "pods" then
  (["POD", "RESTARTS", "CPU-USE", "CPU-REQ", "CPU-LIM", "CPU-%", "MEM-USE", "MEM-REQ", "MEM-LIM", "MEM-%"] | @tsv),
  ($pods[] | ($use[.name].c // null) as $uc | ($use[.name].m // null) as $um
    | (.ready | split("/") | .[0] == .[1]) as $rdy
    | (if (.status | IN("Completed", "Succeeded")) or (.status == "Running" and $rdy) then "g"
       elif .status | test("^(Running|Pending|ContainerCreating|PodInitializing|Terminating|Init:.*)$") then "y"
       else "r" end) as $cls
    | [.name, .restarts,
      ($uc | if . == null then "-" else "\(.)m" end),
      "\(.cr)m", (lim(.cl) | if . == "-" then . else "\(.)m" end),
      "\($cls)\(tok(pct($uc; .cl)))_",
      ($um | if . == null then "-" else "\(.)Mi" end),
      "\(.mr)Mi", (lim(.ml) | if . == "-" then . else "\(.)Mi" end),
      "m\(tok(pct($um; .ml)))_"] | @tsv)
elif $sec == "wl" then
  (["KIND", "NAME", "READY/DESIRED", "CPU-REQ", "MEM-REQ"] | @tsv),
  ($wl[] | [.kind, .name, "\(.ready)/\(.n)", "\(.cr)m", "\(.mr)Mi"] | @tsv)
else
  ($pods | map($use[.name].c // empty) | add) as $uc
  | ($pods | map($use[.name].m // empty) | add) as $um
  | ($pods | map(.cr) | add // 0) as $cr | ($pods | map(.cl) | add // 0) as $cl
  | ($pods | map(.mr) | add // 0) as $mr | ($pods | map(.ml) | add // 0) as $ml
  | (["PODS", "REPLICAS", "CPU-USE", "CPU-REQ", "CPU-LIM", "CPU-%", "MEM-USE", "MEM-REQ", "MEM-LIM", "MEM-%"] | @tsv),
    ([($pods | length), ($wl | map(.n) | add // 0),
      ($uc | if . == null then "-" else "\(.)m" end), "\($cr)m",
      (lim($cl) | if . == "-" then . else "\(.)m" end), "g\(tok(pct($uc; $cl)))_",
      ($um | if . == null then "-" else "\(.)Mi" end), "\($mr)Mi",
      (lim($ml) | if . == "-" then . else "\(.)Mi" end), "m\(tok(pct($um; $ml)))_"] | @tsv)
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
  local sec title mode
  for sec title in pods PODS wl "WORKLOADS (requests = replicas x request por pod)" total TOTAL
  do
    mode=0; [[ $sec == pods ]] && mode=1; [[ $sec == total ]] && mode=2
    printf '\n%s%s%s\n' "$c" "$title" "$r"
    jq -r --arg top "$top" --arg sec "$sec" "$_KUBE_RESOURCES_JQ" <<< "$json" |
      column -t -s $'\t' |
      awk -v b="$b" -v r="$r" -v mode=$mode '
        function rep(ch, n,   o) { while (n-- > 0) o = o ch; return o }
        function bar(p,   n, fill) {
          if (p == "---") return b == "" ? "-----" : "\033[38;5;240m" rep("▬", 5) r
          n = int(p * 5 / 100 + 0.5); if (p > 0 && n < 1) n = 1; if (n > 5) n = 5
          if (b == "") return rep("#", n) rep(".", 5 - n)
          fill = (p < 70) ? 32 : (p < 90) ? 33 : 31
          return "\033[" fill "m" rep("▬", n) "\033[38;5;240m" rep("▬", 5 - n) r
        }
        NR == 1 { print b $0 r; next }
        mode {
          nm = $1; line = $0
          if (match(line, /m([0-9]{3}|---)_/))
            line = substr(line, 1, RSTART - 1) bar(substr(line, RSTART + 1, 3)) substr(line, RSTART + 5)
          if (match(line, /[gyr]([0-9]{3}|---)_/)) {
            cls = substr(line, RSTART, 1)
            line = substr(line, 1, RSTART - 1) bar(substr(line, RSTART + 1, 3)) substr(line, RSTART + 5)
          }
          if (mode == 1 && b != "" && cls != "g")
            line = (cls == "y" ? "\033[33m" : "\033[31m") nm r substr(line, length(nm) + 1)
          print line; next
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
