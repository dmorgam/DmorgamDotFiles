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

# PATH se define en ~/.zshenv, no aqui: .zshrc no se lee en shells no
# interactivos y la sesion de Hyprland que lanza SDDM es una de ellas.

# Enable vi mode
bindkey -v
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Default editor
export EDITOR=nvim
export VISUAL=nvim

# Bat theme
export BAT_THEME='ansi'
# -- Aliases -----------------------------------------------

alias vim=nvim
alias ip="ip --color=auto"
alias info="info --vi-keys"
type batcat &> /dev/null && alias bat="batcat"

# -- Tools -------------------------------------------------

# Todo ~/.zsh/*.zsh (tema de syntax highlighting, banner, man, k8s, cloud,
# terraform, fzf, eza, herdr, y lo que copien otros installs como herdr-win).
# Va despues de los aliases: man.zsh y fzf.zsh miran `type bat` (alias de
# batcat) y eza.zsh usa IS_TTY.
for zsh_file in "$HOME"/.zsh/*.zsh(N)
do
  source "$zsh_file"
done
unset zsh_file

# -- User config -------------------------------------------


if (( ! IS_TTY ))
then
  normalBanner
  eval "$(starship init zsh)"

  typeset -g _LAST_CMD_STATUS=0
  function _capture_status() { _LAST_CMD_STATUS=$? }
  precmd_functions=(_capture_status ${precmd_functions:#_capture_status})

  function _transient_accept_line() {
    local saved_prompt=$PROMPT saved_rprompt=$RPROMPT
    local color=green
    (( _LAST_CMD_STATUS != 0 )) && color=red
    PROMPT="%F{$color}❯%f "
    RPROMPT=''
    zle reset-prompt
    PROMPT=$saved_prompt
    RPROMPT=$saved_rprompt
    zle .accept-line
  }

  zle -N accept-line _transient_accept_line
else
  ttyBanner
  export PS1="%B%F{yellow}%n%f%b@%B%F{blue}%m%f%b %F{white}%~%  > "
fi
