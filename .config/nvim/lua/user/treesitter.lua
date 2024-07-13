local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end


configs.setup {
  ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", 
  "c_sharp", "c", "dockerfile", "html", "javascript", "json", "regex", "sql", 
  "xml", "yaml" }, ---- ensure_installed = one of "all" or a list of languages put the language you want in this array

  ignore_install = { "" },   -- List of parsers to ignore installing
  sync_install = false,      -- install languages synchronously (only applied to `ensure_installed`)

  highlight = {
    enable = true,       -- false will disable the whole extension
    disable = { "css" }, -- list of language that will be disabled
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
          return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css" } },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

