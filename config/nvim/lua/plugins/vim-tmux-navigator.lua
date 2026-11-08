-- Tmux (y herdr) integration with nvim
--
-- En tmux: vim-tmux-navigator de siempre.
-- En herdr ($HC_TERMINAL_ID): wincmd y, si no hay split hacia ese lado,
-- `herdr-app do pane.go` salta al pane de herdr. Zsh hace lo mismo (~/.zsh/herdr.zsh).

local herdr_dirs = { h = "left", j = "down", k = "up", l = "right" }

local function navigate(dir, tmux_cmd)
  return function()
    if vim.env.TMUX or not vim.env.HC_TERMINAL_ID then
      vim.cmd(tmux_cmd)
      return
    end
    local win = vim.api.nvim_get_current_win()
    vim.cmd("wincmd " .. dir)
    if win == vim.api.nvim_get_current_win() and vim.fn.executable("herdr-app") == 1 then
      vim.system({ "herdr-app", "do", "pane.go", "--direction", herdr_dirs[dir] })
    end
  end
end

return {
  {"christoomey/vim-tmux-navigator",
    -- Los maps son los de `keys`; sin esto el plugin los pisa al cargar
    init = function() vim.g.tmux_navigator_no_mappings = 1 end,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", navigate("h", "TmuxNavigateLeft") },
      { "<c-j>", navigate("j", "TmuxNavigateDown") },
      { "<c-k>", navigate("k", "TmuxNavigateUp") },
      { "<c-l>", navigate("l", "TmuxNavigateRight") },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  }
}
