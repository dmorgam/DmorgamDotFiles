# Dotfiles personales

Mis dotfiles con mi config de nvim y varios.

## Nvim

**Versión de Neovim: 7.x o superior.**
El plugin manager que uso es [vim-plug](https://github.com/junegunn/vim-plug).
Para su instalación  se copia [plug.vim](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
al directorio de autoload de nvim en _~/.local/share/nvim/site/autoload/_.

Vim plug install NeoVim:
```shell
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Archivo de config _config/nvim/init.vim_ se debe copiar a _~/.config/nvim/init.vim_.
Y finalmente dentro de Nvim instalar los plugins:
```vim
:PlugInstall
```

Para instalar la config, ejecutar el script [install.sh --nvim](install.sh).
```shell
$install.sh --nvim
```

