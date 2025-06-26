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
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        opts = function (_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "http")
        end,
    },
    config = function ()
        vim.g.rest_nvim = {
            request = {
                skip_ssl_verification = true
            }
        }

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "json",
            callback = function()
                vim.opt_local.formatprg = "jq ."
            end
        })
    end
  },
}
