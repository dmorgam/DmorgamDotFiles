#!/bin/sh

BASEDIR=$(dirname "$0")

showHelp () {
  echo "Instala la config para el usuario:"
  echo "    --help           -  Muestra la ayuda."
  echo "    --nvim           -  Instala la config de nvim."
  echo "    --nvim --nodeps  -  Instala la config de nvim, sin dependencias."
  echo "    --zsh            -  Instala la config de zsh."
  echo "    --tmux           -  Instala la config de tmux."
  echo "    --etc            -  Instala la config de etc del sistema."
  echo "    --hyprland       -  Instala hyprland y su config."
  echo "    --mutt           -  Instala config de mutt."
}

installNvim () {
    echo "Copiando config..."
    mkdir -p ~/.config/nvim && cp ./config/nvim/init.lua ~/.config/nvim/

    # Snippets
    mkdir -p "$HOME/.config/nvim/snippets"
    cp -rf "$BASEDIR/config/nvim/snippets/"* "$HOME/.config/nvim/snippets/"

    if test "$1" != '--nodeps'
    then
      echo "Instalando dependencias..."

      which apt > /dev/null 2>&1 &&
        sudo apt update &&
        sudo apt install g++ libstdc++6 tidy ripgrep lua5.1 liblua5.1-0 libcurl4-openssl-dev

      which yum > /dev/null 2>&1 &&
        sudo yum install g++ libstdc++ tidy ripgrep lua51 lua51-devel libcurl-devel

      which zypper > /dev/null 2>&1 &&
        sudo zypper install gcc-c++ libstdc++6 tidy ripgrep lua51 lua51-devel libcurl-devel

      which pacman > /dev/null 2>&1 &&
        sudo pacman -S --needed gcc gcc-libs tidy ripgrep lua51 libcurl-gnutls luarocks
    fi
}

installZsh () {
  which pacman > /dev/null 2>&1 &&
    echo "Instalando dependencias ..." &&
    sudo pacman -S --needed starship eza fzf

  echo "Copiando config..."

  cp -f "$BASEDIR/zshrc" "$HOME/.zshrc"
  mkdir -p "$HOME/.zsh"
  cp -rf "$BASEDIR"/zsh/* "$HOME/.zsh"
  cp -f "$BASEDIR/config/starship.toml" "$HOME/.config/starship.toml"

  # Copy fortunes
  mkdir -p "$HOME/.fortune"
  cp -f "$BASEDIR/fortune/custom-quotes" "$HOME/.fortune/custom-quotes"
  cp -f "$BASEDIR/fortune/custom-quotes.dat" "$HOME/.fortune/custom-quotes.dat"
}

installTmux () {
  echo "Copiando config de tmux..."
  cp -f "$BASEDIR/tmux.conf" "$HOME/.tmux.conf"
}

installEtc () {
  echo "Saltando al instalador de etc ..."
  sh $BASEDIR/etc/install.sh
}

installHyprland () {
  echo "Saltando al instalador de hyprland ..."
  sh $BASEDIR/hyprland/install.sh
}

installMutt () {
  echo "Copiando config de mutt..."
  cp -rf $BASEDIR/config/mutt/*  "$HOME/.config/mutt/"
}

case $1 in
  '--help')
    showHelp
    ;;
  '--nvim')
    installNvim "$2"
    ;;
  '--zsh')
    installZsh
    ;;
  '--tmux')
    installTmux
    ;;
  '--etc')
    installEtc
    ;;
  '--hyprland')
    installHyprland
    ;;
  '--mutt')
    installMutt
    ;;
  *)
    showHelp
    ;;
esac
