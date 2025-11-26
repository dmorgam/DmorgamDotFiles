-- LSP Config with internal api

-- cmp integration
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lua LS
vim.lsp.config.lua_ls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/packages/lua-language-server/lua-language-server")
    },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
}

-- Powershell LSP
vim.lsp.config.powershell_es = {
    capabilities = capabilities,
    filetypes = { "ps1" },
    cmd = {
        "pwsh",
        "-NoLogo",
        "-NoProfile",
        "-Command",
        vim.fn.expand("$MASON/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1"),
        "-Stdio"
    },
    settings = {
        powershell = {
            codeFormatting = {
                Preset = 'OTBS'
            }
        }
    },
    init_options = {
        enableProfileLoading = false,
    }
}

-- Python
vim.lsp.config.pylsp = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/packages/python-lsp-server/venv/bin/pylsp")
    },
    filetypes = { 'python' }
}

-- Typescript
vim.lsp.config.ts_ls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/packages/typescript-language-server/node_modules/typescript-language-server/lib/cli.mjs"),
        "--stdio"
    },
    filetypes = { 'javascript', 'typescript' }
}

-- Terraform
vim.lsp.config.terraformls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/packages/terraform-ls/terraform-ls"),
        "serve"
    },
    filetypes = { 'terraform' },
    root_dir = vim.loop.cwd()
}

-- Yaml
vim.lsp.config.yamlls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/packages/yaml-language-server/node_modules/yaml-language-server/bin/yaml-language-server"),
        "--stdio"
    },
    filetypes = { 'yaml' }
}

-- Json
vim.lsp.config.jsonls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/packages/json-lsp/node_modules/vscode-langservers-extracted/bin/vscode-json-language-server"),
        "--stdio"
    },
    filetypes = { "json" }
}

-- Helm
vim.lsp.config.helm_ls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/packages/helm-ls/helm_ls_linux_amd64"),
        "serve",
        "--stdio"
    },
    filetypes = { 'helm' }
}

-- Enable servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('powershell_es')
vim.lsp.enable('pylsp')
vim.lsp.enable('ts_ls')
vim.lsp.enable('terraformls')
vim.lsp.enable('yamlls')
vim.lsp.enable('jsonls')
vim.lsp.enable('helm_ls')
