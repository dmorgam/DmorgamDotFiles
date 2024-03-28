
-- My neovim config rewritten in lua

-- ######################### [ LAZY.NVIM PLUGINS ] #########################################

-- Install lazy.nvim if not exists
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)


-- Load lazy.nvim plugins
require("lazy").setup({

  -- Luarocks
  {"vhyrro/luarocks.nvim", priority = 1000, config = true},

  -- Nio
  {"nvim-neotest/nvim-nio"},

  -- Web dev icons
  {'kyazdani42/nvim-web-devicons'},

  -- Plugins de status bar
  {'nvim-lualine/lualine.nvim'},
  {'akinsho/bufferline.nvim'},
  {'tiagovla/scope.nvim'},

  -- Kanagawa theme
  { "rebelot/kanagawa.nvim"},

  -- Onedark theme
  -- {'navarasu/onedark.nvim'},

  -- Startup screen
  {'goolord/alpha-nvim'},

  -- file tree
  {'kyazdani42/nvim-tree.lua'},

  -- Git support
  {'tpope/vim-fugitive'},

  -- Autoclose brackets
  {'windwp/nvim-autopairs'},

  -- Neovim lsp config 
  {'neovim/nvim-lspconfig'},

  -- Autocomplete
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-cmdline'},
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-vsnip'},
  {'hrsh7th/vim-vsnip'},

  -- Indent blankline show
  {'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },

  -- Telescope (fuzzy finder)
  {'nvim-lua/plenary.nvim'},
  {'nvim-telescope/telescope.nvim'},

  -- Todo plugin
  {'folke/todo-comments.nvim'},

  -- Treesitter
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

  -- Mason nvim
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},

  -- Linter
  {'mfussenegger/nvim-lint'},

  -- Rest Api testing
  {'NTBBloodbath/rest.nvim'},

})


-- ######################### [ Nvim general config ] #########################################

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.list = true
vim.opt.listchars:append("eol:↴")


-- [ Colorscheme ]
vim.cmd('colorscheme kanagawa')


-- [ Custom mappings ]
-- Leader key
vim.g.mapleader = " "

-- Fast buffer movement
vim.api.nvim_set_keymap('n','<leader>k',':bnext<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>j',':bprev<CR>',{ noremap = true })

-- Wipe buffer and switch to another one
vim.api.nvim_set_keymap('n','<leader>d',':bn|bw #<CR>',{ noremap = true })

-- Toggle NvimTree
vim.api.nvim_set_keymap('n','<leader>f',':NvimTreeToggle<CR>',{ noremap = true })

-- Telescope mappings
vim.api.nvim_set_keymap('n','<leader>tf',':Telescope find_files<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>tg',':Telescope live_grep<CR>',{ noremap = true })


-- ########################## [ Graphical clients config ] ###################################
if vim.g.neovide then
  vim.o.guifont = "SauceCodePro Nerd Font:h10"
  vim.opt.autochdir = true
  vim.g.neovide_fullscreen = false
end

-- ########################## [ PLUGIN SETUP ] ###############################################


local alpha = require("alpha")
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


alpha.setup(dashboard.opts)

require("mason").setup()
require("mason-lspconfig").setup()

require("scope").setup()

require("bufferline").setup({
  options = {
    separator_style = { '', '' },
    numbers = "buffer_id",
    show_close_icon = false,
    show_buffer_close_icons = false,
    show_tab_indicators = true,
    indicator = {
      icon  = '▍',
      style = 'icon'
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = "  File Explorer",
        text_align = "center",
        separator = '▐',
        padding = 0,
        highlight = "ModeMsg",
      }
    },
  }
})


require("nvim-tree").setup({
  view = {
    side = "right"
  },
})

-- require("nvim-tree.api").tree.open()


require('lualine').setup({
  options = {
    theme = 'kanagawa',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    globalstatus = true
  }
})


require("nvim-autopairs").setup()


require("ibl").setup ()


require("telescope").setup {
  extensions = {
    live_grep_args = {
      auto_quoting = true
    }
  }
}

require("rest-nvim").setup({
  skip_ssl_verification = true
})
vim.cmd('command! RestNvim lua require(\'rest-nvim\').run()')
vim.cmd('command! RestNvimPreview :lua require(\'rest-nvim\').run(true)')
vim.cmd('command! RestNvimLast :lua require(\'rest-nvim\').last()')


require("todo-comments").setup()


require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "python", "http", "json", "yaml", "javascript", "html", "markdown", "xml", "graphql" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}


-- CMP Autocomplete config
local cmp = require("cmp")
if cmp ~= nil then
  cmp.setup({
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
        { name = "treesitter" },
        { name = 'path' },
        { name = 'buffer', option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end } }
     },
  })
end


-- Set up lspconfig, configure language servers installed.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())


-- LSP LANGUAGES

-- Lua lsp server config
require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = {'vim'} },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
}

-- Python
require('lspconfig').pylsp.setup {}

-- Js/Ts
require('lspconfig').tsserver.setup {}

-- Terraform
require('lspconfig').terraformls.setup {}

-- Yaml
require('lspconfig').yamlls.setup {}

-- Json
require('lspconfig').jsonls.setup {}


-- LINTER

require('lint').linters_by_ft = {
  yaml      = {'yamllint'},
  python    = {'pylint'},
  sh        = {'shellcheck'},
  markdown  = {'markdownlint'},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

