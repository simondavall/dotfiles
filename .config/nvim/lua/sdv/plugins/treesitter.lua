return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({
      modules = {}, -- default : {}
      sync_install = false, -- default : false
      auto_install = false, -- default : true
      ignore_install = {}, -- default : {}

      -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },

      -- ensure these language parsers are installed
      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "css",
        "dockerfile",
        "gitignore",
        "go",
        "graphql",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "razor",
        "regex",
        "rust",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "zig",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
