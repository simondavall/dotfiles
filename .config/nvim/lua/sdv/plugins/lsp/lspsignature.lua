return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    bind = true,
    -- floating_window = true,
    floating_window_above_cur_line = true, -- open window below cursor
    floating_window_off_y = -5, -- move the floating window down 5 lines to prevent hiding cursor
    floating_window_off_x = 20,
    hint_enable = false, -- optional: reduces visual noise
    handler_opts = {
      border = "rounded"
    }
  }
}
