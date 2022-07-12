call plug#begin()

" Plugin de status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Grubvox theme
Plug 'morhetz/gruvbox'
        
" Nerdtree
Plug 'preservim/nerdtree'

" Git support
Plug 'tpope/vim-fugitive'

" Autoclose brackets
Plug 'jiangmiao/auto-pairs'

" Autocomplete
Plug 'Shougo/deoplete.nvim'

call plug#end()

"[ Nvim general config ]
set tabstop=4 shiftwidth=4 expandtab
set number
    

" [ Vim airline config ]
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1

" [ Deoplete config ]
let g:deoplete#enable_at_startup = 1

" [ Colorscheme ]
colorscheme gruvbox

" [ Nerdtree config ]
let g:NERDTreeWinPos = "right"

" [ Open new window settings ]
autocmd VimEnter * NERDTree | wincmd p
autocmd BufWinEnter * NERDTreeMirror
