-- Tmux (y herdr) integration with nvim
--
-- En tmux: vim-tmux-navigator de siempre.
-- En herdr: wincmd y, si no hay split hacia ese lado, salta al pane de herdr.
--   app ($HC_TERMINAL_ID): `herdr-app do pane.go`
--   TUI ($HERDR_ENV=1):    `herdr pane focus`
-- Zsh hace lo mismo (~/.zsh/herdr.zsh).

local herdr_dirs = { h = "left", j = "down", k = "up", l = "right" }

local function herdr_cmd(dir)
  if vim.env.HC_TERMINAL_ID and vim.fn.executable("herdr-app") == 1 then
    return { "herdr-app", "do", "pane.go", "--direction", dir }
  elseif vim.env.HERDR_ENV == "1" and vim.fn.executable("herdr") == 1 then
    return { "herdr", "pane", "focus", "--direction", dir }
  end
end

local function navigate(dir, tmux_cmd)
  return function()
    local cmd = not vim.env.TMUX and herdr_cmd(herdr_dirs[dir])
    if not cmd then
      vim.cmd(tmux_cmd)
      return
    end
    local win = vim.api.nvim_get_current_win()
    vim.cmd("wincmd " .. dir)
    if win == vim.api.nvim_get_current_win() then
      vim.system(cmd)
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
