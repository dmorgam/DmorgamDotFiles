-- Diagnostics config

local diagnostic_signs = {
    [vim.diagnostic.severity.ERROR] = "",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.INFO] = "",
    [vim.diagnostic.severity.HINT] = "󰌵",
}

local function diagnostic_format(diagnostic)
    return string.format(
        "%s %s (%s)",
        diagnostic_signs[diagnostic.severity],
        diagnostic.source,
        diagnostic.code
    )
end

vim.diagnostic.config({

    virtual_text = {
        spacing = 4,
        prefix = "",
        format = diagnostic_format
    },

    signs = {
        text = diagnostic_signs
    },

    underline = true,
    severity_sort = true
})

vim.api.nvim_create_user_command('Diagnostics', function()
    vim.diagnostic.setloclist()
end, {})

-- Autolanzar diagnostics inline
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = "line"
    })
  end,
})
