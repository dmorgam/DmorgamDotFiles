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
vim.opt.signcolumn = "yes"
vim.o.cmdheight = 0

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Scroll
vim.opt.scrolloff = 8

-- preview de sustitucion
vim.opt.inccommand = "split"

-- Busqueda smart y case insensitive
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- tiempo en ms para CursorHold
vim.o.updatetime = 1000

-- 80 column guide
vim.opt.colorcolumn = "80"

-- Hide tabline, present in lualine bufferline
vim.opt.showtabline = 0

-- Colorscheme
vim.cmd('colorscheme catppuccin-macchiato')

-- Color completion menu with normal float for clarity
vim.api.nvim_set_hl(0, "Pmenu", { bg = vim.api.nvim_get_hl(0, { name = "NormalFloat" }).bg })

-- Folding options
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.o.foldlevelstart = 20

-- Easy terminal exit
vim.keymap.set("t", "<leader><Esc>", [[<C-\><C-n>]], { desc = "Salir terminal mode" })

-- Toggle Oil
vim.api.nvim_set_keymap('n','<leader>o',':Oil<CR>',
    { noremap = true, desc = 'Oil File Manager' })

-- Fast buffer movement
vim.api.nvim_set_keymap('n','<leader>k',':bnext<CR>',
    { noremap = true, desc = 'Next Buffer' })
vim.api.nvim_set_keymap('n','<leader>j',':bprev<CR>',
    { noremap = true, desc = 'Previous Buffer' })

-- Wipe buffer and switch to another one
vim.api.nvim_set_keymap('n','<leader>bd',':bn|bw #<CR>',
    { noremap = true, desc = 'Delete Buffer' })

-- Diagnostics
vim.api.nvim_set_keymap('n','<leader>d',':Diagnostics<CR>',
    { noremap = true, desc = 'Diagnostics' })

-- Telescope mappings
vim.api.nvim_set_keymap('n','<leader>ff',':Telescope find_files<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>fg',':Telescope live_grep<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>fb',':Telescope buffers<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>fh',':Telescope help_tags<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>fs',':Telescope lsp_document_symbols<CR>',{ noremap = true })

-- Snacks mappings
vim.keymap.set("n", "<leader>t", function() require("snacks").terminal.toggle() end, { desc = "Terminal" })
vim.keymap.set("n", "<leader>z", function() require("snacks").zen() end, { desc = "Zen mode" })

-- Git mappings
vim.api.nvim_set_keymap('n','<leader>gg',':Neogit<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>gv',':Neogit kind=vsplit<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>gb',':Gitsigns blame<CR>',{ noremap = true })
vim.api.nvim_set_keymap('n','<leader>gd',':Gitsigns diffthis<CR>',{ noremap = true })

-- LSP mappings
vim.api.nvim_set_keymap('n','<leader>ls',':lua vim.lsp.buf.signature_help()<CR>',
    { noremap = true, desc = "LSP Signature Help" })
vim.api.nvim_set_keymap('n','<leader>ld',':lua vim.lsp.buf.definition()<CR>',
    { noremap = true, desc = "LSP Definition/Declaration" })
vim.api.nvim_set_keymap('n','<leader>lr',':lua vim.lsp.buf.references()<CR>',
    { noremap = true, desc = "LSP References" })

-- Autoremove trailing spaces on insert leave
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        if vim.bo.modifiable
        then
            local view = vim.fn.winsaveview()
            vim.cmd([[%s/\s\+$//e]])
            vim.fn.winrestview(view)
        end
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

-- LSP config
require("config.lspconfig")

-- Diagnostics
require("config.diagnostics")

-- Powershell files config (for windows corporate things)
require("config.powershell")

-- GUI config
require("config.gui")

