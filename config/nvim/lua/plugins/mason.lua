-- Mason: LSPs, linters y formatters
--
-- mason-lspconfig no se usa: los servidores se declaran a mano con
-- vim.lsp.config en lua/config/lspconfig.lua. mason-tool-installer se encarga
-- solo de instalar binarios (tambien linters y formatters, que
-- mason-lspconfig no cubre).

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ui = {
        border = 'rounded',
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      -- Nombres de paquete de Mason, no de lspconfig
      ensure_installed = {
        -- LSP
        'bash-language-server',
        'basedpyright',
        'gopls',
        'helm-ls',
        'json-lsp',
        'lua-language-server',
        'powershell-editor-services',
        'ruff',
        'terraform-ls',
        'vtsls',
        'yaml-language-server',

        -- Linters (nvim-lint)
        'markdownlint',
        'shellcheck',
        'yamllint',

        -- Formatters (conform)
        'shfmt',
        'stylua',

        -- Requerido por nvim-treesitter (branch main)
        'tree-sitter-cli',
      },

      run_on_start = true,

      integrations = {
        ['mason-lspconfig'] = false,
        ['mason-null-ls']   = false,
        ['mason-nvim-dap']  = false,
      },
    },
  },
}
