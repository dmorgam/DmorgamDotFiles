#!/bin/sh

BASEDIR=$(dirname "$0")

showHelp () {
  echo "Instala la config para el usuario:"
  echo "    --help           -  Muestra la ayuda."
  echo "    --nvim           -  Instala la config de nvim."
  echo "    --nvim --nodeps  -  Instala la config de nvim, sin dependencias."
  echo "    --zsh            -  Instala la config de zsh."
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
      if which apt > /dev/null 2>&1
      then
        sudo apt update
        sudo apt install g++ libstdc++6 tidy ripgrep lua5.1 liblua5.1-0 libcurl4-openssl-dev
      elif which yum > /dev/null 2>&1
      then
        sudo yum install g++ libstdc++ tidy ripgrep lua51 lua51-devel libcurl-devel
      elif which zypper > /dev/null 2>&1
      then
        sudo zypper install gcc-c++ libstdc++6 tidy ripgrep lua51 lua51-devel libcurl-devel
      fi
    fi
}

installZsh () {
  echo "Copiando config..."

  if test -f "$HOME/.zshrc"
  then
    rm ~/.zshrc
  fi

  if test -f "$HOME/.p10k.zsh"
  then
    rm ~/.p10k.zsh
  fi

  cp "$BASEDIR/zshrc" "$HOME/.zshrc"
  cp "$BASEDIR/p10k.zsh" "$HOME/.p10k.zsh"

  # Copy fortunes
  mkdir -p "$HOME/.fortune"
  cp -f "$BASEDIR/fortune/custom-quotes" "$HOME/.fortune/custom-quotes"
  cp -f "$BASEDIR/fortune/custom-quotes.dat" "$HOME/.fortune/custom-quotes.dat"
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
  *)
    showHelp
    ;;
esac
