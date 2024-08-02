return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    name = "colorscheme: tokyonight",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      local tokyonight = require("tokyonight")
      tokyonight.setup(opts)
      tokyonight.load()
      -- load the colorscheme here
      --vim.cmd([[colorscheme tokyonight-moon]])
    end,
  },
  { "rose-pine/neovim",
    name = "colorscheme: rose-pine",
    lazy = false,
    priority = 50,
  },
  { "lunarvim/darkplus.nvim",
    name = "colorscheme: darkplus",
    lazy = false,
    priority = 50,
  },
  { "catppuccin/nvim",
    name = "colorscheme: catppuccin",
    lazy = false,
    priority = 50,
  }
}
