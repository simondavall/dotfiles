return {
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "user.core.lsp.lspconfig"
      require("user.core.lsp.clangd_lsp")

      local base = require("user.core.lsp.lspconfig")
      local on_attach = base.on_attach
      local capabilities = base.capabilities
      local lspconfig = require("lspconfig")

      lspconfig.clangd.setup {
        on_attach = function (client, bufnr)
          client.server_capabilities.signatureHelpProvider = false
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd"
      }
    }
  },
}
