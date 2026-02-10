return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					yaml = { "yamlfix" },
					yml = { "yamlfix" },
					sh = { "shfmt" },
					bash = { "shfmt" },
					go = { "goimports", "gofumpt" },
					terraform = { "terraform_fmt" },
					hcl = { "terraform_fmt" },
					tf = { "terraform_fmt" },
					json = { "prettier" },
					lua = { "stylua" },
					-- markdown = { "prettier" },
				},

				linters_by_ft = {
					terraform = { "tflint", "tfsec" },
				},

				-- format on save
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},

				formatters = {
					yamlfix = {
						env = {
							YAMLFIX_INDENT_MAPPING = "2",
							YAMLFIX_INDENT_SEQUENCE = "2",
							YAMLFIX_INDENT_OFFSET = "0",
							YAMLFIX_SEQUENCE_STYLE = "block_style",
							YAMLFIX_WHITELINES = "1",
						},
					},
				},
			})
			-- maunal save
			vim.keymap.set({ "n", "v" }, "<leader>fmt", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range" })
		end,
	},

	-- autoinstall formattets
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier",
					"yamlfix",
					"shfmt",
					"goimports",
					"gofumpt",
					"stylua",
					"yamllint",
					"shellcheck",
					"golangci-lint",
					-- terraform
					-- lintiongs

					"tflint",
					"tfsec", -- Security scan

					-- LSP
					"terraformls",
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				terraform = { "tflint", "tfsec" },
				tf = { "tflint", "tfsec" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
