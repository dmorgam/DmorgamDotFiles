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

-- Folding options
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.o.foldlevelstart = 20

-- Toggle Oil
vim.api.nvim_set_keymap('n','<leader>o',':Oil<CR>',{ noremap = true })

-- Fast buffer movement
vim.api.nvim_set_keymap('n','<leader>k',':bnext<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>j',':bprev<CR>',{ noremap = true })

-- Wipe buffer and switch to another one
vim.api.nvim_set_keymap('n','<leader>bd',':bn|bw #<CR>',{ noremap = true })

-- Diagnostics
vim.api.nvim_set_keymap('n','<leader>d',':Diagnostics<CR>',{ noremap = true })

-- Telescope mappings
vim.api.nvim_set_keymap('n','<leader>f',':Telescope find_files<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>tg',':Telescope live_grep<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>b',':Telescope buffers<CR>',{ noremap = true })

-- Neogit mappings
vim.api.nvim_set_keymap('n','<leader>g',':NeoGitToggleSplit<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>gv',':Neogit kind=vsplit<CR>',{ noremap = true })


-- Autoremove trailing spaces on insert leave
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        local view = vim.fn.winsaveview()
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
})


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

-- Diagnostics
require("config.diagnostics")

-- Powershell files config (for windows corporate things)
require("config.powershell")

-- GUI config
require("config.gui")
