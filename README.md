# Dotfiles personales

Mis dotfiles con mi config de nvim y varios.

## NeoVim

Configuracion en lua, solo compatible con NeoVim

**Versión de Neovim: 0.8.x o superior.**
El plugin manager que uso es [lazy.nvim](https://github.com/folke/lazy.nvim).

Archivo de config _config/nvim/init.lua_ se debe copiar a _~/.config/nvim/init.lua_.
Y finalmente dentro de Nvim instalar los plugins:

```vim
:Lazy update
```

Para instalar la config, ejecutar el script [install.sh --nvim](install.sh).

```shell
$install.sh --nvim
```

### Servidores de lenguaje

Están configurados los siguientes servidores (hay que instalarlos y meterlos en el
 path):

#### En python con pip

* [python-lsp-server (pylsp)](https://github.com/python-lsp/python-lsp-server)

  ```shell
  pip install python-lsp-server
  ```

#### En node con npm

* [typescript-language-server (tsserver) para js y ts](https://github.com/theia-ide/typescript-language-server)

  ```shell
  npm install -g typescript typescript-language-server
  ```

#### Binario a compilar o precompilado

* [lua-language-server (sumneko_lua)](https://github.com/sumneko/lua-language-server)

   ```shell
   git clone https://github.com/sumneko/lua-language-server
   ....
   ```

### Treesitter Nvim

Treesitter funciona el neovim 0.8 o superior y necesita las siguientes librerias:

* libstdc++
* g++

Para el plugin de rest api necesita:

* tidy
