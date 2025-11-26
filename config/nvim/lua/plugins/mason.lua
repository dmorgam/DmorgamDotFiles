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
               "helm_ls",
               "lua_ls",
               "powershell_es",
               "pylsp",
               "terraformls",
               "ts_ls",
               "yamlls",
               "jsonls"
           },
      })
    end
  },
}
