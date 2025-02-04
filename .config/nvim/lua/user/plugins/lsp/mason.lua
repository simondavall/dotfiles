return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
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

    mason_lspconfig.setup {
      automatic_installation = true,

      -- list of servers for mason to install
      ensure_installed = {
        "clangd",
        "omnisharp",
        "html",
        "cssls",
        "lua_ls",

        -- TODO: need to set up the following languages (need config in lspconfig.lua file)
        --"bashls",
        --"clangd",
        --"csharp_ls",
        --"dockerls",
        --"docker_compose_language_service",
        --"emmet_ls",
        --"golangci_lint_ls",
        --"graphql",
        --"java_language_server",
        --"prismals",
        --"pyright",
        --"rust_analyzer",
        --"sqlls",
        --"svelte",
        --"tailwindcss",
        --"taplo",
        --"tsserver",
        --"zls"
      },
    }

    mason_tool_installer.setup({
      ensure_installed = {
        --"pylint", -- python linter
        "eslint_d", -- js linter
      },
    })
  end,
}
