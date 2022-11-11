
-- My neovim config rewritten in lua

-- ######################### [ VIMPLUG PLUGINS ] #########################################

vim.call('plug#begin')


-- Web dev icons
vim.fn['plug#'] 'kyazdani42/nvim-web-devicons'

-- Plugins de status bar
vim.fn['plug#'] 'nvim-lualine/lualine.nvim'
vim.fn['plug#'] 'akinsho/bufferline.nvim'

-- Grubvox theme
-- Plug 'morhetz/gruvbox'

-- Tokio Night theme
vim.fn['plug#'] 'folke/tokyonight.nvim'

-- file tree
vim.fn['plug#'] 'kyazdani42/nvim-tree.lua'

-- Git support
vim.fn['plug#'] 'tpope/vim-fugitive'

-- Autoclose brackets
vim.fn['plug#'] 'windwp/nvim-autopairs'

-- Neovim lsp config 
vim.fn['plug#'] 'neovim/nvim-lspconfig'

-- Autocomplete
vim.fn['plug#'] 'hrsh7th/cmp-nvim-lsp'
vim.fn['plug#'] 'hrsh7th/cmp-buffer'
vim.fn['plug#'] 'hrsh7th/cmp-path'
vim.fn['plug#'] 'hrsh7th/cmp-cmdline'
vim.fn['plug#'] 'hrsh7th/nvim-cmp'
vim.fn['plug#'] 'hrsh7th/cmp-vsnip'
vim.fn['plug#'] 'hrsh7th/vim-vsnip'

-- Indent blankline show
vim.fn['plug#'] 'lukas-reineke/indent-blankline.nvim'

-- Telescope (fuzzy finder)
vim.fn['plug#'] 'nvim-lua/plenary.nvim'
vim.fn['plug#'] 'nvim-telescope/telescope.nvim'

-- Todo plugin
vim.fn['plug#'] 'folke/todo-comments.nvim'

-- Treesitter
vim.fn['plug#']('nvim-treesitter/nvim-treesitter', { ['do'] = vim.fn['TSUpdate'] })

-- Rest Api testing
vim.fn['plug#'] 'NTBBloodbath/rest.nvim'


vim.call('plug#end')

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
vim.cmd('colorscheme tokyonight-night')


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
  open_on_setup = true,
  view = {
    side = "right"
  },
})


require('lualine').setup({
  options = {
    theme = 'palenight',
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


-- Set up lspconfig, configure language servers installed.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lua lsp server config
require'lspconfig'.sumneko_lua.setup {
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


