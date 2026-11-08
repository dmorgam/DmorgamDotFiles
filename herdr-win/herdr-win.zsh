#!/bin/zsh

#
# Herdr desktop en Windows con el shell del core en wsl.exe
# (%APPDATA%\herdr-core\config.toml: shell = ["wsl.exe", ..., "--cd", "~"]).
#
# Herdr saca el cwd de cada pane del proceso de Windows (wsl.exe), que no
# cambia con los cd de Linux, asi que todo pane nuevo arranca en ~. Cada
# prompt guarda $PWD; un shell nuevo que arranca en ~ salta al ultimo.
#
# Necesita WSLENV=HC_TERMINAL_ID/u en las variables de usuario de Windows
# para distinguir los terminales de herdr del resto de WSL.
#

if [[ -n "$HC_TERMINAL_ID" && -n "$WSL_DISTRO_NAME" && -z "$TMUX" ]]
then
  _herdr_last_cwd="${XDG_CACHE_HOME:-$HOME/.cache}/herdr-last-cwd"
  mkdir -p "${_herdr_last_cwd:h}"

  _herdr_save_cwd () {
    print -r -- "$PWD" >| "$_herdr_last_cwd"
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _herdr_save_cwd

  if [[ "$PWD" == "$HOME" && -r "$_herdr_last_cwd" ]]
  then
    _herdr_dir=$(<"$_herdr_last_cwd")
    [[ -d "$_herdr_dir" ]] && cd -q -- "$_herdr_dir"
    unset _herdr_dir
  fi
fi
