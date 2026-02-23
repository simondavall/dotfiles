return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    bind = true,
    floating_window = true,
    floating_window_above_cur_line = false, -- open window below cursor
    floating_window_off_y = 10, -- +ve = down, -ve = up
    floating_window_off_x = -100,-- +ve = left, -ve = right
    hint_enable = false,
    handler_opts = {
      border = "rounded"
    }
  }
}
