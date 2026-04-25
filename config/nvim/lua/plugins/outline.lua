-- Outline (symbols sidebar)

return {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
        { "<leader>fo", "<cmd>Outline<CR>", desc = "Toggle Outline" },
    },
    opts = {
        outline_window = {
            position = "left",
            width = 20,
            relative_width = true,
            auto_close = false,
            auto_jump = true,
            show_numbers = false,
            show_relative_numbers = false,
        },
        outline_items = {
            show_symbol_details = true,
            show_symbol_lineno = false,
            highlight_hovered_item = true,
            auto_set_cursor = true,
        },
        symbol_folding = {
            autofold_depth = 1,
            auto_unfold = { hovered = true },
        },
        symbols = {
            filter = {
                default = {
                    "Class", "Constructor", "Enum", "Function",
                    "Interface", "Method", "Module", "Namespace",
                    "Package", "Property", "Struct", "Trait",
                },
                python = { "Class", "Function", "Method", "Module" },
                lua = { "Class", "Function", "Method", "Module" },
            },
        },
    },
}
