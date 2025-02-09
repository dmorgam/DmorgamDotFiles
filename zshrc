# My zsh config

autoload -Uz compinit
compinit

# -- Antidote plugins --------------------------------------

# Modos de TTY y normales (para el login)
if [[ "$(tty)" != /dev/tty* ]]
then
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
  antidote bundle romkatv/powerlevel10k
  antidote bundle zsh-users/zsh-autosuggestions
  antidote bundle zsh-users/zsh-syntax-highlighting
else
  export PS1="%B%F{yellow}%n%f%b@%B%F{blue}%m%f%b %F{white}%~%  > "
fi

# -- User configuration -----------------------------------

# Path
PATH="$PATH:/$HOME/.local/bin"

# Kubectl configuration
if type kubectl &> /dev/null
then
  source <(kubectl completion zsh)
  alias k=kubectl
fi

if type kubecolor &> /dev/null
then
  compdef kubecolor=kubectl
  alias k=kubecolor
fi

if type oc &> /dev/null
then
  source <(oc completion zsh)
  compdef _oc oc
fi

# Aws cli autocomplete
if type aws_completer &> /dev/null
then
  complete -C '~/.local/bin/aws_completer' aws
fi

# Terraform
if type terraform &> /dev/null
then
  alias tf=terraform
  complete -o nospace -C ~/.local/bin/terraform terraform
  compdef __start_terraform tf
fi

# Enable vi mode
bindkey -v
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Default editor
EDITOR=nvim

# Reverse history search like bash
bindkey '^R' history-incremental-search-backward

# Aliases
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

# Banner

# Modos de TTY y normales (para el login)
if [[ "$(tty)" != /dev/tty* ]]
then
  echo "dmorgamThinkPad" | figlet -f smslant | lolcat
  fortune ~/.fortune/custom-quotes | lolcat
  echo ""
else
  echo ""
  # Porcentaje de bateria
  percent=$(cat /sys/class/power_supply/BAT0/capacity)
  width=30
  (( blobs = percent * width / 100 ))
  printf "\rBATTERY:     \e[92m%3d%% [%-${width}s]\e[0m\n" $percent "$( printf "%${blobs}s" | tr " " "=" )"
  echo "CONNECTIONS:"
  nmcli con show --active
  echo ""
  printf "\rLaunch GUI:  \e[94mHyprland\e[0m\n"
  echo ""
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
