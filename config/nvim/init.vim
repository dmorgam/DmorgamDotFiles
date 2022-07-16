call plug#begin()

" Web dev icons
Plug 'kyazdani42/nvim-web-devicons'

" Plugins de status bar
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'

" Grubvox theme
Plug 'morhetz/gruvbox'
        
" file tree
Plug 'kyazdani42/nvim-tree.lua'

" Git support
Plug 'tpope/vim-fugitive'

" Autoclose brackets
Plug 'windwp/nvim-autopairs'

" Neovim lsp config 
Plug 'neovim/nvim-lspconfig'

" Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'


call plug#end()

"[ Nvim general config ]
set tabstop=2 shiftwidth=2 expandtab
set number
set termguicolors
    

" [ Colorscheme ]
colorscheme gruvbox


" --------------- Lua settings ------------------------
lua << END
require("bufferline").setup({
  options = {
    separator_style = "thin"
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
    theme = 'gruvbox_dark',
  }
})

require("nvim-autopairs").setup()


-- Snipet autoclose NvimTree ( Buggy when exit on not saved files)
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})


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
      { name = "buffer" },
   },
})

END
