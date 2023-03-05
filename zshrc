# My zsh config

# -- Antigen plugins --------------------------------------
#
# Source antigen package manager
source ~/.zsh/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load standard oh my zsh plugins
antigen bundle git 
antigen bundle vi-mode

# Load other plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell 

# apply antigen changes.
antigen apply


# -- User configuration -----------------------------------

# Enable vi mode
bindkey -v
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'


# Aliases
alias vim=nvim

