-- Telescope

return {
  -- Telescope (fuzzy finder)
  {'nvim-lua/plenary.nvim'},
  {
    'nvim-telescope/telescope.nvim',
    config = function ()

      require("telescope").setup {
        defaults = {
          initial_mode = 'normal',
          path_display = {
            'truncate'
          }
        },
        extensions = {
          live_grep_args = {
            auto_quoting = true
          }
        }
      }

    end
  },
}
