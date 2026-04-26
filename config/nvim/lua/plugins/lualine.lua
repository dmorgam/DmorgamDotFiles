-- Lualine

return {
    {
        'nvim-lualine/lualine.nvim',
        config = function ()

            require('lualine').setup({
                options = {
                    theme = 'catppuccin-nvim',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    globalstatus = true
                },
                sections = {
                    lualine_a = { { 'mode', separator = { left = '', right = '' } } },
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = { {'filename', path = 1} },
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress','location'},
                    lualine_z = { { 'tabs', separator = { left = '', right = '' } } }
                },
                winbar = {
                    lualine_b = { 'filetype' },
                    lualine_c = { 'filename' },
                    lualine_y = { 'lsp_status' },
                },
                inactive_winbar = {
                    lualine_b = { 'filetype' },
                    lualine_c = { 'filename' },
                    lualine_y = { 'lsp_status' },
                },
            })

        end
    }
}
