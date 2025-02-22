# My zsh config

autoload -Uz compinit
compinit

# -- Antidote plugins --------------------------------------

# Download antidote if needed
[[ -e ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

# Source antidote package manager
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Dinamic load mode
source <(antidote init)

# Load the oh-my-zsh library.
antidote bundle ohmyzsh/ohmyzsh path:lib

# Load standard oh my zsh plugins
antidote bundle ohmyzsh/ohmyzsh path:plugins/git
antidote bundle ohmyzsh/ohmyzsh path:plugins/vi-mode

# Load other plugins
antidote bundle zsh-users/zsh-autosuggestions
antidote bundle zsh-users/zsh-syntax-highlighting


# -- Local vars --------------------------------------------

PATH="$PATH:/$HOME/.local/bin"

# Enable vi mode
bindkey -v
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Default editor
EDITOR=nvim

# -- Tools -------------------------------------------------

# Kubernetes configuration
type kubectl &> /dev/null &&
  source <(kubectl completion zsh) &&
  alias k=kubectl

# Kubecolor
type kubecolor &> /dev/null &&
  compdef kubecolor=kubectl &&
  alias k=kubecolor

# Openshift
type oc &> /dev/null &&
  source <(oc completion zsh) &&
  compdef _oc oc

# Aws cli autocomplete
type aws_completer &> /dev/null &&
  complete -C '~/.local/bin/aws_completer' aws

# Terraform
type terraform &> /dev/null &&
  alias tf=terraform &&
  complete -o nospace -C ~/.local/bin/terraform terraform &&
  compdef __start_terraform tf

## Fuzzy finder
type fzf &> /dev/null &&
  source <(fzf --zsh) &&
  type bat &> /dev/null &&
    alias fzf='fzf --preview="bat --color=always {}"' ||
    alias fzf='fzf --preview="cat {}"'

## Eza
type eza &> /dev/null &&
  alias ls="eza --icons=always" &&
  alias ll="eza --icons=always --long --git"

# -- Aliases -----------------------------------------------

alias vim=nvim
alias man="LESS_TERMCAP_mb=$'\e[1;31m' \
           LESS_TERMCAP_md=$'\e[1;33m' \
           LESS_TERMCAP_so=$'\e[01;42;30m' \
           LESS_TERMCAP_us=$'\e[01;37m' \
           LESS_TERMCAP_me=$'\e[0m' \
           LESS_TERMCAP_se=$'\e[0m' \
           LESS_TERMCAP_ue=$'\e[0m' \
           GROFF_NO_SGR=1 \
           MANPAGER='less -s -M +Gg' man"

alias ip="ip --color=auto"

# -- User config -------------------------------------------

# Reverse history search like bash
bindkey '^R' history-incremental-search-backward

# Modos de TTY y normales (para el login)
if [[ "$(tty)" != /dev/tty* ]]
then
  echo $(cat /etc/hostname) | figlet -f smslant | lolcat
  fortune ~/.fortune/custom-quotes | lolcat
  echo ""
  eval "$(starship init zsh)"
else
  type eza &> /dev/null &&
    alias ls="eza --icons=never" &&
    alias ll="eza --icons=never --long --git"

  # Porcentaje de bateria
  width=30
  percent=$(cat /sys/class/power_supply/BAT0/capacity)
  (( blobs = percent * width / 100 ))
  printf "\n\rBATTERY:     \e[92m%3d%% [%-${width}s]\e[0m\n" $percent "$( printf "%${blobs}s" | tr " " "=" )"
  echo "CONNECTIONS:"
  nmcli con show --active
  printf "\n\rLaunch GUI:  \e[94mHyprland\e[0m\n\n"
  export PS1="%B%F{yellow}%n%f%b@%B%F{blue}%m%f%b %F{white}%~%  > "
fi
