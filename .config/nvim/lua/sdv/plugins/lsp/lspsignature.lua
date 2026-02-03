return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    bind = true,
    -- floating_window = true,
    -- floating_window_above_cur_line = true,
    floating_window_off_y = -2, -- move the floating window up 2 lines to prevent hiding cursor
    hint_enable = false, -- optional: reduces visual noise
    handler_opts = {
      border = "rounded"
    }
  }
}
