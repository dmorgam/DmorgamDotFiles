#!/bin/zsh

#
# kube-config: elige con fzf un kubeconfig de ~/.kube y lo exporta a KUBECONFIG.
#

(( $+commands[fzf] )) || return 0

kube-config () {
  local dir="$HOME/.kube" file

  file=$(find "$dir" -type f \( -name '*.yaml' -o -name '*.yml' \) -printf '%P\n' 2> /dev/null |
    sort | command fzf --height=40% --prompt='KUBECONFIG> ' \
      --preview "kubectl --kubeconfig $dir/{} config get-contexts 2> /dev/null") || return 1

  export KUBECONFIG="$dir/$file"
  echo "KUBECONFIG=$KUBECONFIG"
}
