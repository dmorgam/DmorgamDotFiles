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
      local luasnip = require("luasnip")

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

             ["<Tab>"] = cmp.mapping(function(fallback)
               if cmp.visible() then
                 cmp.select_next_item()
               elseif luasnip.expand_or_jumpable() then
                 luasnip.expand_or_jump()
               elseif has_words_before() then
                 cmp.complete()
               else
                 fallback()
               end
             end, { "i", "s" }),

             ["<S-Tab>"] = cmp.mapping(function(fallback)
               if cmp.visible() then
                 cmp.select_prev_item()
               elseif luasnip.jumpable(-1) then
                 luasnip.jump(-1)
               else
                 fallback()
               end
             end, { "i", "s" }),
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

      -- For toggle choice nodes
      vim.api.nvim_set_keymap("i", "<C-e>", "<Plug>luasnip-next-choice", {})
      vim.api.nvim_set_keymap("s", "<C-e>", "<Plug>luasnip-next-choice", {})

    end
  },

  {'saadparwaiz1/cmp_luasnip'},
}
