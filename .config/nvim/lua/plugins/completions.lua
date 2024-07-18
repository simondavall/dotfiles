return {  
---- cmp plugins
  { "hrsh7th/nvim-cmp" },         -- The completion plugin
  { "hrsh7th/cmp-buffer" },       -- buffer completions
  { "hrsh7th/cmp-path" },         -- path completions
  { "hrsh7th/cmp-cmdline" },      -- cmdline completions
  { "saadparwaiz1/cmp_luasnip" }, -- snippet completions

---- snippets
  { "L3MON4D3/LuaSnip",                  --snippet engine
	  version = "v2.*",                   -- follow latest release.
	  build = "make install_jsregexp",    -- install jsregexp (optional!).
    dependencies = { "rafamadriz/friendly-snippets" },   -- a bunch of snippets to use
  },
}
