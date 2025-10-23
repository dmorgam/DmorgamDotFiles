-- Lsp config

return {
  {
    'neovim/nvim-lspconfig',
    config = function ()

      -- cmp integration
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = {'vim'} },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      })

      -- LSP servers
      local servers = { "pylsp", "ts_ls", "terraformls",
                        "yamlls", "jsonls" }

      for _, server in ipairs(servers) do
          vim.lsp.config[server] = {
              capabilities = capabilities,
          }
      end

      -- Powershell LSP
      vim.lsp.config.powershell_es = {
          capabilities = capabilities,
          cmd = {
            vim.fn.expand("$HOME") ..
            "/.local/share/nvim/mason/packages/powershell-editor-services/PowerShellEditorServices.Host",
          },
          init_options = {
            enableProfileLoading = false,
          }
      }

      -- Enable servers
      vim.lsp.enable(vim.lsp.config.lua_ls)

      for _, server in ipairs(servers) do
        vim.lsp.enable(vim.lsp.config[server])
      end

      vim.lsp.enable(vim.lsp.config.powershell_es)

    end
  }
}
