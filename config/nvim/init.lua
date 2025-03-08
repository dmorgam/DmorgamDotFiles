-- Neovim config

-- Leader key
vim.g.mapleader = " "

-- Lazy Vim
require("config.lazy")
require("lazy").setup("plugins")

-- User options
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

-- 80 column guide
vim.opt.colorcolumn = "80"

-- Hide tabline, present in lualine bufferline
vim.opt.showtabline = 0

-- Colorscheme
vim.cmd('colorscheme catppuccin-macchiato')


-- Toggle Oil
vim.api.nvim_set_keymap('n','<leader>f',':Oil<CR>',{ noremap = true })

-- Fast buffer movement
vim.api.nvim_set_keymap('n','<leader>k',':bnext<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>j',':bprev<CR>',{ noremap = true })

-- Wipe buffer and switch to another one
vim.api.nvim_set_keymap('n','<leader>d',':bn|bw #<CR>',{ noremap = true })

-- Telescope mappings
vim.api.nvim_set_keymap('n','<leader>tf',':Telescope find_files<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>tg',':Telescope live_grep<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>b',':Telescope buffers<CR>',{ noremap = true })

-- Neogit mappings
vim.api.nvim_set_keymap('n','<leader>g',':Neogit<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>gv',':Neogit kind=vsplit<CR>',{ noremap = true })


-- Open markdown files on firefox
vim.api.nvim_create_user_command('MarkdownView', function()
    local filepath = vim.fn.expand('%:p')

    -- WSL
    if vim.loop.os_uname().release:find("WSL") then
        local windows_filepath = vim.fn.system('wslpath -w "' .. filepath .. '"')
        vim.fn.jobstart({'/mnt/c/Users/dmorenog/AppData/Local/Microsoft/WindowsApps/firefox.exe', windows_filepath}, { detach = true })

    -- Linux
    elseif vim.loop.os_uname().sysname:find("Linux") then
        vim.fn.jobstart({'firefox', filepath}, { detach = true })
    end
end, {})


-- Config for neovide
if vim.g.neovide then
    vim.o.guifont = "SauceCodePro Nerd Font:h10"
    vim.opt.autochdir = true
    vim.g.neovide_fullscreen = false
end
