-- Diagnostics config

local diagnostic_signs = {
    [vim.diagnostic.severity.ERROR] = "",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.INFO] = "",
    [vim.diagnostic.severity.HINT] = "󰌵",
}

-- Los diagnostics de plugins (lazy.nvim, mason, ...) no traen source ni code:
-- sin este fallback string.format los imprime como "nil (nil)".
local function diagnostic_format(diagnostic)
    local icon = diagnostic_signs[diagnostic.severity] or ""

    if not diagnostic.source then
        return string.format("%s %s", icon, diagnostic.message)
    end

    if not diagnostic.code then
        return string.format("%s %s", icon, diagnostic.source)
    end

    return string.format(
        "%s %s (%s)",
        icon,
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
