# Dotfiles personales

Mis dotfiles con mi config de nvim, vt y varios.

## NeoVim

Configuracion en lua, solo compatible con NeoVim

**Versión de Neovim: 0.10.x o superior.**
El plugin manager que uso es [lazy.nvim](https://github.com/folke/lazy.nvim).

Archivo de config _config/nvim/init.lua_ se debe copiar a _~/.config/nvim/init.lua_.
Y finalmente dentro de Nvim instalar los plugins:

```vim
:Lazy update
```

Para instalar la config, ejecutar el script [install.sh --nvim](install.sh).

```shell
> install.sh --nvim
```

### Servidores de lenguaje

Instalar via Mason

## ZSH

Se instala via install.sh

```shell
> install.sh --zsh
```

## Tmux

Se instala via install.sh

```shell
> install.sh --tmux
```

## Etc

En el directorio etc se encuentran archivos para configurar el sistema.

- etc/issue (/etc/issue para personalizar el login de las TTY.)
- etc/custom-vt-colors.service (para configurar colores custom para las TTY.)
- etc/install.sh (script que instala todo lo anterior)
