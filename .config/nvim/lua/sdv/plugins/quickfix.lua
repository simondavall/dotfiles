return {
  vim.keymap.set("n", "<leader>qt", "<cmd>TodoQuickFix<CR>", { desc = "Quickfix todos" }),
  vim.keymap.set("n", "<leader>qc", ":call setqflist([])<CR>", { desc = "Clear Quickfix list" }),
  vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open Quickfix list" }),
  vim.keymap.set("n", "<leader>qx", ":cclose<CR>", { desc = "Close Quickfix list" }),
  vim.keymap.set("n", "<leader>qr", ":cfdo %s/<find>/<replace>/gc", { desc = "Find & Replace across all QuickFix files" }),
  vim.keymap.set("n", "<leader>qu", ":cfdo update<CR>", { desc = "Update all Quickfixes" }),
}
