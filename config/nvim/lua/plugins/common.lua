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

    -- Http client
    {
        "mistweaverco/kulala.nvim",
        keys = {
            { "<leader>Rs", desc = "Send request" },
            { "<leader>Ra", desc = "Send all requests" },
            { "<leader>Rb", desc = "Open scratchpad" },
        },
        ft = {"http", "rest"},
        opts = {
            global_keymaps = true,
            global_keymaps_prefix = "<leader>R",
            kulala_keymaps_prefix = "",
            additional_curl_options = { "--insecure" }
        },
    },

    -- Which key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    }
}
