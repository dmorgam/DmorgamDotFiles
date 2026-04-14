-- Treesiter

return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = function()
            -- Borrar queries de markdown del plugin para usar los de neovim (compatibles con 0.12)
            local ts_path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
            vim.fn.delete(ts_path .. "/queries/markdown", "rf")
            vim.fn.delete(ts_path .. "/queries/markdown_inline", "rf")
            vim.cmd("TSUpdate")
        end,
        config = function ()

            require('nvim-treesitter.configs').setup ({
                -- markdown y markdown_inline usan los parsers/queries del sistema
                -- (los de la rama main son incompatibles con nvim 0.12)
                ensure_installed = { "lua", "python", "http", "json",
                "yaml", "javascript", "html",
                "xml", "graphql", "powershell" },
                ignore_install = { "markdown", "markdown_inline" },
                modules = {},
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },

                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v',
                            ['@function.outer'] = 'V',
                            ['@class.outer'] = '<c-v>',
                        },
                        include_surrounding_whitespace = true,
                    }
                }
            })
        end
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
    }
}
