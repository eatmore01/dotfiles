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

	-- Mason-lspconfig - link mason with lspconfig
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

	-- nvim-lspconfig - lsp settings
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
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
				settings = {
					yaml = {
						schemaStore = {
							enable = true,
							url = "https://www.schemastore.org/api/json/catalog.json",
						},

						schemas = {
							kubernetes = {
								"*.yaml",
								"*.yml",
								"k8s*.yaml",
								"kube*.yaml",
								"*/k8s/*.yaml",
							},

							-- gitlab
							["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
								".gitlab-ci.yml",
								".gitlab-ci.yaml",
								"gitlab-ci*.yml",
								"*/cicd/*.yml",
							},
						},
					},
				},
			}
			vim.lsp.enable("yamlls")

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

			-- Terraform
			vim.lsp.config.terraformls = {
				filetypes = { "terraform", "tf", "hcl" },
			}
			vim.lsp.enable("terraformls")

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
