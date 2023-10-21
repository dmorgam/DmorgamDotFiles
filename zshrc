# My zsh config

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
antidote bundle ohmyzsh/ohmyzsh path:themes/robbyrussell.zsh-theme

# Load other plugins
antidote bundle zsh-users/zsh-autosuggestions
antidote bundle zsh-users/zsh-syntax-highlighting


# -- User configuration -----------------------------------

# Kubectl configuration
if type kubectl &> /dev/null
then
  source <(kubectl completion zsh)
  alias k=kubectl
fi

# Aws cli autocomplete
if type aws_completer &> /dev/null
then
  complete -C '~/.local/bin/aws_completer' aws
fi


# Enable vi mode
bindkey -v
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'


# Aliases
alias vim=nvim

# Banner
cat /etc/hostname | figlet -f smslant | lolcat
echo ""

