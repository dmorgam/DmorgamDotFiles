#!/bin/sh

BASEDIR=$(dirname "$0")

showHelp () {
  echo "Instala la config para el usuario:"
  echo "    --help  -  Muestra la ayuda."
  echo "    --nvim  -  Instala la config de nvim."
  echo "    --zsh   -  Instala la config de zsh."
}

installNvim () {
    echo "Copiando config..."
    mkdir -p ~/.config/nvim && cp ./config/nvim/init.lua ~/.config/nvim/

    echo "Instalando dependencias..."
    if $(which apt > /dev/null 2>&1)
    then
      sudo apt update
      sudo apt install g++ libstdc++ tidy ripgrep
    elif $(which yum > /dev/null 2>&1)
    then
      sudo yum install g++ libstdc++ tidy ripgrep
    elif $(which zypper > /dev/null 2>&1)
    then
      sudo zypper install gcc-c++ libstdc++6 tidy ripgrep
    fi
}

installZsh () {
  echo "Copiando config..."

  if test -f "~/.zshrc"
  then
    rm ~/.zshrc
  fi

  cp $BASEDIR/zshrc ~/.zshrc
}

case $1 in
  '--help')
    showHelp
    ;;
  '--nvim')
    installNvim
    ;;
  '--zsh')
    installZsh
    ;;
  *)
    showHelp
    ;;
esac
