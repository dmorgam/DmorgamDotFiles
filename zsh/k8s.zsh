#!/bin/zsh

#
# Config de los cli de kubernetes/openshift
#

# Kubernetes configuration
type kubectl &> /dev/null &&
  source <(kubectl completion zsh) &&
  alias k=kubectl

# Kubecolor
type kubecolor &> /dev/null &&
  compdef kubecolor=kubectl &&
  alias k=kubecolor &&
  alias oc="env KUBECTL_COMMAND=oc kubecolor"

# Openshift
type oc &> /dev/null &&
  source <(oc completion zsh) &&
  compdef _oc oc
