# My zsh config

autoload -Uz compinit
compinit

# -- Pre-plugins variables ---------------------------------

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES

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

# -- Check if tty mode -------------------------------------
if [[ "$(tty)" != /dev/tty* ]] ||
      cat /proc/version | grep -q Microsoft
then
  export IS_TTY=0
else
  export IS_TTY=1
fi

# -- Local vars --------------------------------------------

PATH="$PATH:/$HOME/.local/bin"

# Enable vi mode
bindkey -v
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

# Custom colors for prompt commands
source "$HOME/.zsh/zsh-syntax-highlighting-theme.zsh"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Default editor
EDITOR=nvim

# Bat theme
export BAT_THEME='ansi'
# -- Aliases -----------------------------------------------

alias vim=nvim
alias ip="ip --color=auto"
alias info="info --vi-keys"
type batcat &> /dev/null && alias bat="batcat"

# -- Tools -------------------------------------------------

# Banner functions
source "$HOME/.zsh/banner.zsh"

# Man config
source "$HOME/.zsh/man.zsh"

# K8s tools
source "$HOME/.zsh/k8s.zsh"

# Cloud cli tools
source "$HOME/.zsh/cloud.zsh"

# Terraform
source "$HOME/.zsh/terraform.zsh"

## Fuzzy finder
source "$HOME/.zsh/fzf.zsh"

## Eza
source "$HOME/.zsh/eza.zsh"

# -- User config -------------------------------------------


if (( ! IS_TTY ))
then
  normalBanner
  eval "$(starship init zsh)"
else
  ttyBanner
  export PS1="%B%F{yellow}%n%f%b@%B%F{blue}%m%f%b %F{white}%~%  > "
fi
