-- Luacheck configuration for Neovim
globals = {
    "vim", -- Neovim global
}

-- Ignore line length warnings
max_line_length = false

-- Ignore unused arguments warnings for common patterns
ignore = {
    "631", -- Line too long
    "212", -- Unused argument
    "213", -- Unused loop variable
}
