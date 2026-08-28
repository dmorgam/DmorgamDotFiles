-- Autocompletado: blink.cmp + LuaSnip

return {
    -- Motor de snippets (snippets propios en lua/snippets)
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        config = function ()

            require("luasnip.loaders.from_lua").load({
                paths = vim.fn.stdpath("config") .. "/lua/snippets"
            })

            -- For toggle choice nodes.
            -- Sin <Plug>: vim.keymap.set no remapea por defecto (noremap=1) y el
            -- <Plug> quedaria sin resolver.
            vim.keymap.set({ "i", "s" }, "<C-e>", function()
                local luasnip = require("luasnip")
                if luasnip.choice_active() then
                    luasnip.change_choice(1)
                end
            end, { desc = "LuaSnip: siguiente opcion del choice node" })

        end
    },

    -- Motor de completado
    {
        'saghen/blink.cmp',
        version = '1.*',
        dependencies = { 'L3MON4D3/LuaSnip' },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            snippets = { preset = 'luasnip' },

            appearance = { nerd_font_variant = 'mono' },

            keymap = {
                preset = 'none',
                ['<C-p>']     = { 'select_prev', 'fallback' },
                ['<C-n>']     = { 'select_next', 'fallback' },
                ['<C-d>']     = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>']     = { 'scroll_documentation_down', 'fallback' },
                ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' },
                ['<C-e>']     = { 'hide', 'fallback' },
                ['<CR>']      = { 'accept', 'fallback' },
                -- No meter funciones custom que llamen a luasnip.jump/expand aqui:
                -- blink registra estos keymaps con expr=true y el textlock rompe la
                -- sesion de LuaSnip. snippet_forward/backward ya lo hacen bien.
                ['<Tab>']     = { 'select_next', 'snippet_forward', 'fallback' },
                ['<S-Tab>']   = { 'select_prev', 'snippet_backward', 'fallback' },
            },

            completion = {
                menu = { border = 'rounded' },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = { border = 'rounded' },
                },
            },

            -- Sustituye a cmp-nvim-lsp-signature-help
            signature = {
                enabled = true,
                window = { border = 'rounded' },
            },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
                providers = {
                    -- API de nvim en ficheros lua
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 100,
                    },
                    -- Completar desde todos los buffers, no solo los visibles
                    buffer = {
                        opts = {
                            get_bufnrs = function() return vim.api.nvim_list_bufs() end,
                        },
                    },
                },
            },

            fuzzy = { implementation = 'prefer_rust_with_warning' },
        },
        opts_extend = { 'sources.default' },
    },
}
