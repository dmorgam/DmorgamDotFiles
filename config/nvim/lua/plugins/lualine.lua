-- Lualine

return {
    {
        'nvim-lualine/lualine.nvim',
        config = function ()
            local C = require('catppuccin.palettes').get_palette(require('catppuccin').options.flavour)

            local mode_colors = {
                n = C.blue, i = C.green, v = C.mauve, V = C.mauve, ['\22'] = C.mauve,
                s = C.mauve, S = C.mauve, ['\19'] = C.mauve,
                R = C.red, c = C.peach, t = C.green,
            }
            local function mode_color()
                local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
                return { fg = mode_colors[mode] or C.blue, gui = 'bold' }
            end

            -- Section c/x fg = separator color, components set their own
            local section = { a = { fg = C.overlay0, bg = 'NONE' }, c = { fg = C.overlay0, bg = 'NONE' } }
            local theme = { normal = section, insert = section, visual = section,
                            replace = section, command = section, terminal = section, inactive = section }

            require('lualine').setup({
                options = {
                    theme = theme,
                    component_separators = { left = '·', right = '·' },
                    section_separators = { left = '', right = '' },
                    globalstatus = true
                },
                sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                        { 'mode', color = mode_color },
                        { 'filename', path = 1, color = { fg = C.sapphire } },
                        { 'branch', color = { fg = C.yellow } },
                        { 'diff', diff_color = {
                            added = { fg = C.green }, modified = { fg = C.peach }, removed = { fg = C.red },
                        } },
                        'diagnostics',
                    },
                    lualine_x = {
                        { 'encoding', color = { fg = C.subtext0 } },
                        { 'fileformat', color = { fg = C.subtext0 } },
                        { 'filetype', color = { fg = C.subtext0 } },
                        { 'progress', color = { fg = C.blue } },
                        { 'location', color = { fg = C.blue } },
                        { 'tabs', tabs_color = {
                            active = { fg = C.mauve, gui = 'bold' }, inactive = { fg = C.overlay1 },
                        } },
                    },
                    lualine_y = {},
                    lualine_z = {},
                },
                inactive_sections = {
                    lualine_a = {}, lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {}, lualine_z = {},
                },
                winbar = {
                    lualine_c = {
                        { 'filetype', color = { fg = C.subtext0 } },
                        { 'filename', color = { fg = C.text } },
                    },
                    lualine_x = { { 'lsp_status', color = { fg = C.overlay1 } } },
                },
                inactive_winbar = {
                    lualine_c = {
                        { 'filetype', colored = false, color = { fg = C.overlay0 } },
                        { 'filename', color = { fg = C.overlay0 } },
                    },
                    lualine_x = { { 'lsp_status', color = { fg = C.overlay0 } } },
                },
            })

        end
    }
}
