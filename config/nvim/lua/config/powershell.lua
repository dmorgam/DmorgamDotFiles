-- Config to work in powershell script in neovim

-- powershell files to microsoft line break at load
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.ps1", "*.psm1"},
  callback = function()
    vim.bo.fileformat = "dos"
  end,
})

-- powershell files to microsoft line break and BOM at write
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.ps1", "*.psm1"},
  callback = function()
    vim.bo.fileformat  = "dos"
    vim.opt_local.bomb = true
    vim.opt_local.fileencoding = "utf-8"
  end,
})
