-- Git support

return {
  {
    'lewis6991/gitsigns.nvim',
    config = function ()
      require('gitsigns').setup()
    end
  },
  {"NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function ()

      require('neogit').setup({
        kind = 'split',
        graph_style = 'unicode'
      })

    end
  },
}
