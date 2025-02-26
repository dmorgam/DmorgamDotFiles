-- Common tiny plugins

return {
  -- Nvim nio
  {"nvim-neotest/nvim-nio"},

  -- Webdev icons
  {'nvim-tree/nvim-web-devicons'},

  -- Indent blankline show
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function ()
      require("ibl").setup ()
    end
  },

  -- Todo plugin
  {
    'folke/todo-comments.nvim',
    config = function ()
      require("todo-comments").setup()
    end
  },

  -- Helm
  {'towolf/vim-helm', ft = 'helm'},

  -- Rest Api testing
  {
    'rest-nvim/rest.nvim',
    config = function ()

      require("rest-nvim").setup({
        default_config = {
          skip_ssl_verification = true
        }
      })

    end
  },
}
