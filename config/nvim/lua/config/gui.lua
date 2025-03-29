-- Config for guis

-- Config for neovide
if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"
    vim.opt.autochdir = true
    vim.g.neovide_fullscreen = false

    -- Set ctrl c ctrl v, as neovide is uses as replacement of notepad
    -- on windows machines, on linux, only terminal is used.
     vim.api.nvim_set_keymap('n', '<C-S-c>', '"+y', { noremap = true})
     vim.api.nvim_set_keymap('v', '<C-S-c>', '"+y', { noremap = true})
     vim.api.nvim_set_keymap('i', '<C-S-v>', '<C-R>+', { noremap = true})
end
