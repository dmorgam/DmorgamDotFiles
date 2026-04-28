-- Snacks Nvim

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            terminal = {
                direction = "horizontal",
                win = {
                    height = 0.3
                }
            },
            notifier = {
                enabled = true
            },
            indent = {
                enabled = true
            },
            scroll = {
                enabled = true
            },
            statuscolumn = {
                enabled = true
            },
            bigfile = {
                enabled = true
            },
            scratch = {
                enabled = true
            },
            words = {
                enabled = true
            },
            zen = {
                enabled = true
            },
            explorer = {
                enabled = true,
                replace_netrw = true,
            },
            picker = {
                ui_select = true,
                sources = {
                    explorer = {
                        layout = {
                            preset = "sidebar",
                            preview = true,
                            layout = {
                                width = 0.2
                            }
                        },
                        hidden = true,
                    },
                },
            },

            -- Dashboard configuration
            dashboard = {
                enabled = true,

                preset = {
                    keys = {
                        { icon = '', key = "e", desc = "New file", action = ":ene | startinsert" },
                        { icon = '', key = "f", desc = "Find file", action = ":lua Snacks.picker.files()" },
                        { icon = '', key = "r", desc = "Recent", action = ":lua Snacks.picker.recent()" },
                        { icon = '󰈞', key = "g", desc = "Grep", action = ":lua Snacks.picker.grep()" },
                        { icon = '', key = "l", desc = "Lazy Packages", action = ":Lazy" },
                        { icon = '󰏔', key = "m", desc = "Mason Packages", action = ":Mason" },
                        { icon = '', key = "q", desc = "Quit NeoVim", action = ":confirm qa" },
                    },

                    header = table.concat({
                        "                                                                    ",
                        "      ████ ██████           █████      ██                     ",
                        "     ███████████             █████                             ",
                        "     █████████ ███████████████████ ███   ███████████   ",
                        "    █████████  ███    █████████████ █████ ██████████████   ",
                        "   █████████ ██████████ █████████ █████ █████ ████ █████   ",
                        " ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
                        "██████  █████████████████████ ████ █████ █████ ████ ██████ "
                    }, "\n")
                }
            }
        }
    }
}
