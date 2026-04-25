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

-- Toggle Explorer
vim.keymap.set('n','<leader>a',function() Snacks.explorer() end,
    { desc = 'File Explorer' })

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

-- Picker mappings (snacks)
vim.keymap.set('n','<leader>ff',function() Snacks.picker.files() end,        { desc = "Find Files" })
vim.keymap.set('n','<leader>fg',function() Snacks.picker.grep() end,         { desc = "Live Grep" })
vim.keymap.set('n','<leader>fb',function() Snacks.picker.buffers() end,      { desc = "Buffers" })
vim.keymap.set('n','<leader>fh',function() Snacks.picker.help() end,         { desc = "Help Tags" })
vim.keymap.set('n','<leader>fr',function() Snacks.picker.recent() end,       { desc = "Recent Files" })
vim.keymap.set('n','<leader>fs',function() Snacks.picker.lsp_symbols() end,  { desc = "Document Symbols" })
vim.keymap.set('n','<leader>fw',function() Snacks.picker.lsp_workspace_symbols() end, { desc = "Workspace Symbols" })

-- Snacks mappings
vim.keymap.set("n", "<leader>t", function() require("snacks").terminal.toggle() end, { desc = "Terminal" })
vim.keymap.set("n", "<leader>z", function() require("snacks").zen() end, { desc = "Zen mode" })
vim.keymap.set("n", "<leader>sb", function() require("snacks").scratch() end,
    { desc = "Scratch Buffer" })
vim.keymap.set("n", "<leader>ss", function() require("snacks").scratch.select() end,
    { desc = "Select Scratch Buffer" })

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

