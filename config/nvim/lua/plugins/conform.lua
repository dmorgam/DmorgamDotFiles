-- Formatters

return {
  {
    'stevearc/conform.nvim',
    cmd = 'ConformInfo',
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        lua       = { 'stylua' },
        python    = { 'ruff_organize_imports', 'ruff_format' },
        sh        = { 'shfmt' },
        bash      = { 'shfmt' },
        zsh       = { 'shfmt' },
        terraform = { 'terraform_fmt' },
        hcl       = { 'terraform_fmt' },
      },

      -- El resto de filetypes cae al formateo del LSP
      default_format_opts = {
        lsp_format = 'fallback',
      },
    },
    init = function ()
      -- gq usa conform
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
