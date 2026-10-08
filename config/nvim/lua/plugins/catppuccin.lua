-- Catpuccin theme

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      transparent_background = false,
      custom_highlights = function(C)
        return {
          StatusLine = { bg = C.none },
          StatusLineNC = { bg = C.none },
        }
      end,
    }
  },
}
