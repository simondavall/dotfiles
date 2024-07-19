return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

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
      -- list of servers for mason to install
      ensure_installed = {
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",

        -- TODO: need to set up the following languages (need config in lspconfig.lua file)
        --"bashls",
        --"clangd",
        --"csharp_ls",
        --"onmisharp",
        --"dockerls",
        --"docker_compose_language_service",
        --"golangci_lint_ls",
        --"java_language_server",
        --"rust_analyzer",
        --"sqlls",
        --"taplo",
        --"zls"
      },
    })
  end,
}
