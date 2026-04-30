-- Mason

return {
  {
    'williamboman/mason.nvim',
    config = function ()
      require("mason").setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function ()
      require("mason-lspconfig").setup({
           ensure_installed = {
               "bashls",
               "helm_ls",
               "lua_ls",
               "gopls",
               "powershell_es",
               "basedpyright",
               "terraformls",
               "vtsls",
               "yamlls",
               "jsonls"
           },
      })
    end
  },
}
