-- Lsp config

return {
  {
    'neovim/nvim-lspconfig',
    config = function ()

      require('lspconfig').lua_ls.setup {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = {'vim'} },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      }

      -- cmp integration
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- LSP servers
      local servers = { "pylsp", "ts_ls", "terraformls",
                        "yamlls", "jsonls" }

      for _, server in ipairs(servers) do
          require('lspconfig')[server].setup {
            capabilities = capabilities
          }
      end

    end
  }
}
