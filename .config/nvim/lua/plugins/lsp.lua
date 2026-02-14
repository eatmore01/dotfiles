return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "yamlls",
                    "bashls",
                    "gopls",
                    "terraformls",
                    "lua_ls",
                    "jsonls",
                    "dockerls",
                },
                automatic_installation = true,
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- Terraform
            local tf_capabilities = vim.lsp.protocol.make_client_capabilities()
            tf_capabilities.textDocument.completion.completionItem.snippetSupport = true
            tf_capabilities = vim.tbl_deep_extend("force", tf_capabilities, capabilities)

            vim.lsp.config.terraformls = {
                capabilities = tf_capabilities,
                filetypes = { "terraform", "tf", "hcl" },
            }
            vim.lsp.enable("terraformls")

            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

                    vim.keymap.set("n", "K", function()
                        local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
                        if #diagnostics > 0 then
                            vim.diagnostic.open_float(nil, {
                                scope = "line",
                                border = "rounded",
                                source = "always",
                            })
                        else
                            vim.lsp.buf.hover()
                        end
                    end, opts)

                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                end,
            })

            -- YAML
            vim.lsp.config.yamlls = {
                cmd = { "yaml-language-server", "--stdio" },
                filetypes = { "yaml", "yml" },
                root_markers = { ".git" },
                single_file_support = true,
                capabilities = capabilities,
                settings = {
                    redhat = { telemetry = { enabled = false } },
                    yaml = {
                        validate = true,
                        completion = true,
                        hover = true,
                        format = { enable = false },
                        schemaStore = {
                            enable = true,
                            url = "https://www.schemastore.org/api/json/catalog.json",
                        },
                        schemaDownload = { enable = true },
                        schemas = {
                            kubernetes = "*.yaml",
                        },
                    },
                },
            }
            vim.lsp.enable("yamlls")

            local function set_yaml_schema_smart(schema_url, schema_name)
                local bufnr = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "yamlls" })

                local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 30, false)
                local kind = nil
                local api_version = nil

                for _, line in ipairs(lines) do
                    local kind_match = line:match("^%s*kind:%s*(%w+)")
                    if kind_match then
                        kind = kind_match
                    end

                    local api_match = line:match("^%s*apiVersion:%s*(.+)$")
                    if api_match then
                        api_version = vim.trim(api_match)
                    end
                end

                for _, client in ipairs(clients) do
                    if kind and api_version and schema_name == "Kubernetes" then
                        local kind_lower = kind:lower()
                        local schema_path

                        local api_group, api_ver = api_version:match("^(.+)/(.+)$")

                        if api_group and api_ver then
                            local group_normalized = api_group:gsub("%.", "")

                            schema_path = string.format(
                                "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.35.0-standalone-strict/%s-%s-%s.json",
                                kind_lower,
                                group_normalized,
                                api_ver
                            )
                        else
                            schema_path = string.format(
                                "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.35.0-standalone-strict/%s-%s.json",
                                kind_lower,
                                api_version
                            )
                        end

                        client.config.settings.yaml.schemas = {
                            [schema_path] = vim.fn.expand("%:t")
                        }

                        vim.notify(string.format("✓ Schema: %s (%s - %s)", schema_name, kind, api_version),
                            vim.log.levels.INFO)
                    else
                        client.config.settings.yaml.schemas = {
                            [schema_url] = vim.fn.expand("%:t")
                        }
                        vim.notify("✓ Schema: " .. schema_name, vim.log.levels.INFO)
                    end

                    client.notify("workspace/didChangeConfiguration", {
                        settings = client.config.settings,
                    })

                    vim.defer_fn(function()
                        vim.diagnostic.reset(nil, bufnr)
                    end, 500)
                end
            end


            vim.api.nvim_create_user_command("YamlSchemaGitlab", function()
                set_yaml_schema_smart(
                    "https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json",
                    "GitLab CI"
                )
            end, { desc = "Set GitLab CI schema" })

            vim.api.nvim_create_user_command("YamlSchemaK8s", function()
                set_yaml_schema_smart(
                    "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.35.0-standalone-strict/all.json",
                    "Kubernetes"
                )
            end, { desc = "Set Kubernetes schema" })

            vim.api.nvim_create_autocmd("BufReadPost", {
                pattern = { "*.yaml", "*.yml" },
                callback = function()
                    local lines = vim.api.nvim_buf_get_lines(0, 0, 20, false)
                    local has_kind = false

                    for _, line in ipairs(lines) do
                        if line:match("^%s*kind:%s*%w+") then
                            has_kind = true
                            break
                        end
                    end

                    if has_kind then
                        vim.defer_fn(function()
                            vim.cmd("YamlSchemaK8s")
                        end, 500)
                    end
                end,
            })

            vim.keymap.set("n", "<leader>y", function()
                local schemas = {
                    { name = "🔵 Kubernetes", cmd = "YamlSchemaK8s" },
                    { name = "🦊 GitLab CI", cmd = "YamlSchemaGitlab" },
                }

                vim.ui.select(
                    vim.tbl_map(function(s) return s.name end, schemas),
                    { prompt = "Select YAML Schema:" },
                    function(choice)
                        if choice then
                            for _, schema in ipairs(schemas) do
                                if schema.name == choice then
                                    vim.cmd(schema.cmd)
                                    break
                                end
                            end
                        end
                    end
                )
            end, { desc = "Select YAML Schema" })

            vim.keymap.set("n", "<leader>yy", function()
                local bufnr = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "yamlls" })

                if #clients > 0 then
                    local schemas = clients[1].config.settings.yaml.schemas
                    local schema_names = {}
                    for key in pairs(schemas) do
                        local name = key:match("([^/]+)%.json$") or key
                        table.insert(schema_names, "✓ " .. name)
                    end
                    vim.notify(table.concat(schema_names, "\n"), vim.log.levels.INFO)
                else
                    vim.notify("No yamlls client attached", vim.log.levels.WARN)
                end
            end, { desc = "Show current YAML schema" })

            -- Bash
            vim.lsp.config.bashls = {
                filetypes = { "sh", "bash" },
            }
            vim.lsp.enable("bashls")

            -- Go
            vim.lsp.config.gopls = {
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            }
            vim.lsp.enable("gopls")

            -- Lua
            vim.lsp.config.lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            }
            vim.lsp.enable("lua_ls")

            -- JSON
            vim.lsp.config.jsonls = {}
            vim.lsp.enable("jsonls")

            -- Docker
            vim.lsp.config.dockerls = {}
            vim.lsp.enable("dockerls")
        end,
    },
}
