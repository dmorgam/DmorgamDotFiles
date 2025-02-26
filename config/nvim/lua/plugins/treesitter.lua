-- Treesiter

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function ()

      require('nvim-treesitter.configs').setup ({
        ensure_installed = { "lua", "python", "http", "json",
                             "yaml", "javascript", "html",
                             "markdown", "xml", "graphql" },
        ignore_install = {},
        modules = {},
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })

    end
  },
}
