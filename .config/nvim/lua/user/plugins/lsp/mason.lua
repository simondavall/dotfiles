return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			automatic_installation = true,
			ensure_installed = {
				"clangd",
				"omnisharp",
				"gopls",
				"html",
				"cssls",
				"lua_ls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
        "gofumpt",
        "goimports-reviser",
				"eslint_d", -- js linter
				"stylua",
			},
		})
	end,
}
