-- Autocomplete plugins

return {
  -- Autopairs
  {
    'windwp/nvim-autopairs',
    config = function ()
      require("nvim-autopairs").setup()
    end
  },

  -- cmp
  {'hrsh7th/cmp-nvim-lsp'},

  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-cmdline'},

  {
    'hrsh7th/nvim-cmp',
    config = function ()

      local cmp = require("cmp")

      if cmp ~= nil then

        cmp.setup({
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
            end
          },
          mapping = {
             ["<C-p>"] = cmp.mapping.select_prev_item(),
             ["<C-n>"] = cmp.mapping.select_next_item(),
             ["<C-d>"] = cmp.mapping.scroll_docs(-4),
             ["<C-f>"] = cmp.mapping.scroll_docs(4),
             ["<C-Space>"] = cmp.mapping.complete(),
             ["<C-e>"] = cmp.mapping.close(),
             ["<CR>"] = cmp.mapping.confirm({
               behavior = cmp.ConfirmBehavior.Replace,
               select = true,
             }),
             ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
             ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
          },
          sources = {
            { name = "nvim_lsp" },
            { name = 'luasnip' },
            { name = "treesitter" },
            { name = 'path' },
            { name = 'buffer', option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end } }
          },
        })

      end
    end
  },

  -- Luasnip snippets
  {
    'L3MON4D3/LuaSnip',
    config = function ()

      require("luasnip.loaders.from_lua").load({
        paths = vim.fn.stdpath("config") .. "/lua/snippets"
      })

    end
  },

  {'saadparwaiz1/cmp_luasnip'},
}
