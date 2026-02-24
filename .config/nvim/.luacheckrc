-- Luacheck configuration for Neovim
globals = {
  "globals", -- Explicitly declared
  "max_line_length", -- Explicitly declared
  "ignore", -- Explicitly declared
  "Snacks", -- global defined by snacks.nvim
  "vim", -- Neovim global
}

-- Ignore line length warnings
max_line_length = false

-- Ignore unused arguments warnings for common patterns
ignore = {
  "631", -- Line too long
  "212", -- Unused argument
  "213", -- Unused loop variable
  "111", -- Global variable in lowercase (e.g., vim)
}
