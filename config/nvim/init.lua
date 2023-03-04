
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

  -- Web dev icons
  {'kyazdani42/nvim-web-devicons'},

  -- Plugins de status bar
  {'nvim-lualine/lualine.nvim'},
  {'akinsho/bufferline.nvim'},

  -- Monokai theme
  {'tanvirtin/monokai.nvim'},

  -- Grubvox theme
  -- {'ellisonleao/gruvbox.nvim'},

  -- Tokyo Night theme
  -- {'folke/tokyonight.nvim'},

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
  {'lukas-reineke/indent-blankline.nvim'},

  -- Telescope (fuzzy finder)
  {'nvim-lua/plenary.nvim'},
  {'nvim-telescope/telescope.nvim'},

  -- Todo plugin
  {'folke/todo-comments.nvim'},

  -- Treesitter
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

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

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

-- [ Colorscheme ]
vim.cmd('colorscheme monokai')



-- Snipet autoclose NvimTree ( Buggy when exit on not saved files)
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})


-- ########################## [ PLUGIN SETUP ] ###############################################


require("alpha").setup(require'alpha.themes.startify'.config)


require("bufferline").setup({
  options = {
    separator_style = 'thick',
    numbers = "buffer_id",
    show_close_icon = false,
    show_buffer_close_icons = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "  File Explorer",
        text_align = "left",
        separator = true
      }
    },
  }
})


require("nvim-tree").setup({
  view = {
    side = "right"
  },
})

require("nvim-tree.api").tree.open()


require('lualine').setup({
  options = {
    theme = 'powerline',
    component_separators = { left = '\\', right = '/' },
    section_separators = { left = '', right = '' },
    globalstatus = true
  }
})


require("nvim-autopairs").setup()


require("indent_blankline").setup ({
    show_end_of_line = true,
})


require("rest-nvim").setup({
  skip_ssl_verification = true
})
vim.cmd('command! RestNvim lua require(\'rest-nvim\').run()')
vim.cmd('command! RestNvimPreview :lua require(\'rest-nvim\').run(true)')
vim.cmd('command! RestNvimLast :lua require(\'rest-nvim\').last()')


require("todo-comments").setup()


require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "python", "http", "json", "yaml", "javascript", "html", "markdown" },
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
        { name = "buffer" },
     },
  })
end


-- Set up lspconfig, configure language servers installed.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lua lsp server config
require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = {'vim'} },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
}

-- Servers with standard config
local servers = { 'pylsp','tsserver' }

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
  }
end


