#!/bin/sh

showHelp () {
  echo "Instala la config para el usuario:"
  echo "    --help  -  Muestra la ayuda."
  echo "    --nvim  -  Instala la config de nvim."
}

installNvim () {
    echo "Instalando Vim Plug..."
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo "Copiando config..."
    mkdir -p ~/.config/nvim && cp ./config/nvim/init.vim ~/.config/nvim/

    echo "Instalando plugins..."
    nvim +PlugInstall +qall
}

case $1 in
  '--help')
    showHelp
    ;;
  '--nvim')
    installNvim
    ;;
  *)
    showHelp
    ;;
esac
