-- Alpha banner

return {
  -- Alpha banner
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()

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
        hl = "Title",
        position = "center",
      }

      dashboard.section.buttons.val = {
        dashboard.button( "e", "  - New file"       , ":ene <BAR> startinsert <CR>"),
        dashboard.button( "f", "  - Find file"      , ":Telescope find_files<CR>"),
        dashboard.button( "r", "  - Recent"         , ":Telescope oldfiles<CR>"),
        dashboard.button( "l", "  - Lazy Packages"  , ":Lazy<CR>"),
        dashboard.button( "m", "  - Mason Packages" , ":Mason<CR>"),
        dashboard.button( "q", "  - Quit NeoVim"    , ":qa<CR>"),
      }

      require("alpha").setup(dashboard.opts)
    end
  }
}
