-- Noice

return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            views = {
                cmdline_popup = {
                    position = {
                        row = "95%",
                        col = "50%"
                    },
                    size = {
                        width = "95%",
                        height = "auto"
                    }
                }
            },

            cmdline = {
                format = {
                    search_down = {
                        kind = "search",
                        pattern = "^/",
                        icon = "/",
                        lang = "regex",
                    },
                    search_up = {
                        kind = "search",
                        pattern = "^%?",
                        icon = "?",
                        lang = "regex",
                    },
                    cmdline = {
                        pattern = "^:",
                        icon = ":",
                        lang = "vim",
                    },
                    shell = {
                        pattern = "^:!",
                        icon = ":!",
                        lang = "bash",
                    }
                }
            }
        },

        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    }
}
