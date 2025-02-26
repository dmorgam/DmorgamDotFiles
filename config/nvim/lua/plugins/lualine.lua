-- Lualine

return {
  {
    'nvim-lualine/lualine.nvim',
    config = function ()

      require('lualine').setup({
        options = {
          theme = 'catppuccin',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = true
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {{'filename', path = 1}},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress','location'},
          lualine_z = {'tabs'}
        }
      })

    end
  }
}
