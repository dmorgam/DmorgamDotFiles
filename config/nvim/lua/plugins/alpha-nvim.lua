-- Alpha banner

return {
    -- Alpha banner
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()

            local function footer()
                local date     = os.date(" %d/%m/%Y")
                local plugins  = " " .. #require("lazy").plugins() .. ' plugins'
                local packages = "󰏔 " .. #require("mason-registry").get_installed_packages() .. ' pkgs'
                local version  = vim.version()
                local nvim_version_info = "  " .. version.major .. "." .. version.minor .. "." .. version.patch

                return date .. " - " .. plugins .. " - " .. packages .. " - " .. nvim_version_info
            end

            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = {
                [[                                                                       ]],
                [[                                                                     ]],
                [[       ████ ██████           █████      ██                     ]],
                [[      ███████████             █████                             ]],
                [[      █████████ ███████████████████ ███   ███████████   ]],
                [[     █████████  ███    █████████████ █████ ██████████████   ]],
                [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
                [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
                [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
                [[                                                                       ]]
            }

            dashboard.section.header.opts = {
                hl = "String",
                position = "center",
            }

            dashboard.section.buttons.val = {
                dashboard.button( "e", "  New file"       , ":ene <BAR> startinsert <CR>"),
                dashboard.button( "f", "  Find file"      , ":Telescope find_files<CR>"),
                dashboard.button( "r", "  Recent"         , ":Telescope oldfiles<CR>"),
                dashboard.button( "l", "  Lazy Packages"  , ":Lazy<CR>"),
                dashboard.button( "m", "󰏔  Mason Packages" , ":Mason<CR>"),
                dashboard.button( "q", "  Quit NeoVim"    , ":qa<CR>"),
            }

            dashboard.section.footer.val = footer()

            dashboard.config.layout = {
                { type = "padding", val = 1 },
                dashboard.section.header,
                { type = "padding", val = 1 },
                dashboard.section.buttons,
                { type = "padding", val = 2 },
                dashboard.section.footer,
            }

            require("alpha").setup(dashboard.opts)
        end
    }
}
