-- LSP Config with internal api

-- cmp integration
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lua LS
vim.lsp.config.lua_ls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/bin/lua-language-server")
    },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', 'stylua.toml', '.stylua.toml', '.git' },
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
    root_markers = { '.git', '*.psd1', '*.psm1' },
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
vim.lsp.config.basedpyright = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/bin/basedpyright-langserver"),
        "--stdio"
    },
    filetypes = { 'python' },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        'pyrightconfig.json',
        '.git'
    }
}

-- Go
vim.lsp.config.gopls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/bin/gopls"),
        "serve"
    },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { 'go.work', 'go.mod', 'go.sum', '.git' },
    settings = {
        gopls = {
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
            completeUnimported = true,
            analyses = {
                unusedparams = true,
                unusedwrite = true,
                unusedvariable = true,
                shadow = true,
                nilness = true,
                useany = true,
                fieldalignment = false,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            codelenses = {
                gc_details = true,
                generate = true,
                regenerate_cgo = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
        }
    }
}

-- Typescript
vim.lsp.config.vtsls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/bin/vtsls"),
        "--stdio"
    },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' }
}

-- Terraform
vim.lsp.config.terraformls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/bin/terraform-ls"),
        "serve"
    },
    filetypes = { 'terraform' },
    root_markers = { '.terraform', '.terraform.lock.hcl', '.git' }
}

-- Yaml
vim.lsp.config.yamlls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/bin/yaml-language-server"),
        "--stdio"
    },
    filetypes = { 'yaml' },
    root_markers = { '.git' }
}

-- Json
vim.lsp.config.jsonls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/bin/vscode-json-language-server"),
        "--stdio"
    },
    filetypes = { "json" },
    root_markers = { 'package.json', '.git' }
}

-- Bash
vim.lsp.config.bashls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/bin/bash-language-server"),
        "start"
    },
    filetypes = { 'sh', 'bash', 'zsh' },
    root_markers = { '.git' }
}

-- Helm
vim.lsp.config.helm_ls = {
    capabilities = capabilities,
    cmd = {
        vim.fn.expand("$MASON/bin/helm_ls"),
        "serve",
        "--stdio"
    },
    filetypes = { 'helm' },
    root_markers = { 'Chart.yaml', '.git' }
}

-- Enable servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('powershell_es')
vim.lsp.enable('basedpyright')
vim.lsp.enable('vtsls')
vim.lsp.enable('terraformls')
vim.lsp.enable('yamlls')
vim.lsp.enable('jsonls')
vim.lsp.enable('helm_ls')
vim.lsp.enable('bashls')
vim.lsp.enable('gopls')
