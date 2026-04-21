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

            -- Dashboard configuration
            dashboard = {
                enabled = true,

                preset = {
                    keys = {
                        { icon = '', key = "e", desc = "New file", action = ":ene | startinsert" },
                        { icon = '', key = "f", desc = "Find file", action = ":Telescope find_files" },
                        { icon = '', key = "r", desc = "Recent", action = ":Telescope oldfiles" },
                        { icon = '󰈞', key = "g", desc = "Grep", action = ":Telescope live_grep" },
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
