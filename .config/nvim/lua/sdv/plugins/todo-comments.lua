return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    todo_comments.setup({
      keywords = {
        FIX = {	alt = { "fix", "bug", "issue", "FIXME", "BUG", "FIXIT", "ISSUE" } },
        -- todo: sdv Find some improved icons for this list
        TODO = { alt = { "todo", "Todo" } },
				HACK = { alt = { "hack", "Hack" } },
				WARN = { alt = { "warn", "Warn", "WARNING", "XXX" } },
				PERF = { alt = { "perf", "Perf", "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { alt = { "note", "Note", "INFO" } },
				TEST = { alt = { "test", "Test", "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "BOLD", -- default: NONE
        bg = "NONE", -- default: BOLD
      },
      highlight = {
        keyword = "fg", -- defualt: wide
      }
    })
  end,
}
