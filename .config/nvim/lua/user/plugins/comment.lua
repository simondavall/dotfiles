-- TODO: Some of the keymaps seem borked, also check other languages like C# and C
-- see comment on the repository setup page
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    --FIX: this line was causing a 'too long' error
    --local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    comment.setup()
    -- enable comment
    --comment.setup({
      -- for commenting tsx, jsx, svelte, html files
      --pre_hook = ts_context_commentstring.create_pre_hook(),
    --})

  end,
}
