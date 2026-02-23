return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
      "Weissle/persistent-breakpoints.nvim",
    },
    config = function()
      local dap = require("dap")

      require("persistent-breakpoints").setup({
        load_breakpoints_event = { "BufReadPost" },
      })
      require("dap-go").setup()
      require("neotest").setup({
        adapters = {
          require("neotest-dotnet"),
        },
      })

      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg"

      local netcoredbg_adapter = {
        type = "executable",
        command = mason_path,
        args = { "--interpreter=vscode" },
      }

      dap.adapters.netcoredbg = netcoredbg_adapter -- needed for normal debugging
      dap.adapters.coreclr = netcoredbg_adapter -- needed for unit test debugging

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Launch",
          request = "launch",
          program = function()
            vim.cmd("silent !dotnet build --no-restore | redraw")
            return require("dap-dll-autopicker").build_dll_path()
          end,
          -- justMyCode = false,
          -- stopAtEntry = false,
          env = {
            ASPNETCORE_ENVIRONMENT = function()
              return "Development"
            end,
            ASPNETCORE_URLS = function()
              -- todo-sdv: hard coding the local uri is awkward. Look at ways of making this more flexible.
              return "https://localhost:7069"
            end,
          },
        },
      }
      -- Configure debug visuals
      vim.fn.sign_define("DapBreakpoint", { text = "🟤", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "⛔", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapStopped", { text = "👉", texthl = "Visual", linehl = "Visual" })
      vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "DiagnosticInfo" })

      local pdap = require("persistent-breakpoints.api")
      local map = vim.keymap.set
      map("n", "<F5>", dap.continue, { noremap = true, silent = true, desc = "Run in debug mode" })
      map("n", "<F8>", dap.step_out, { noremap = true, silent = true, desc = "Step out" })
      map("n", "<F9>", pdap.toggle_breakpoint, { noremap = true, silent = true, desc = "Toggle breakpoint" })
      map("n", "<F10>", dap.step_over, { noremap = true, silent = true, desc = "Step over" })
      map("n", "<F11>", dap.step_into, { noremap = true, silent = true, desc = "Step into" })
      map("n", "<F12>", dap.step_back, { noremap = true, silent = true, desc = "Step back" })

      map("n", "<leader>db", pdap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      map("n", "<leader>dq", pdap.set_conditional_breakpoint, { desc = "Set conditional breakpoint" })
      map("n", "<leader>dc", pdap.clear_all_breakpoints, { desc = "Clear all breakpoints" })
      -- map("n", "<leader>dl", pdap.set_log_point, { desc = "Set log point" })

      map("n", "<leader>dro", dap.repl.open, { noremap = true, silent = true, desc = "Open REPL" })
      map("n", "<leader>drc", dap.repl.close, { noremap = true, silent = true, desc = "Open REPL" })

      map("n", "<leader>dx", dap.terminate, { desc = "Terminates the debug session" })
      --map("n", "<leader>dx", dap.disconnect, { desc = "Disconect from the debug session" }) -- used if attaached to running process

      map("n", "<leader>dl", dap.run_last, { noremap = true, silent = true, desc = "Run last debug session" }) -- remembers previously used debug config settings
      local run_test = "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>"
      map("n", "<leader>dt", run_test, { noremap = true, silent = true, desc = "Debug nearest test" })

      local dapui = require("dapui")
      dapui.setup({
        icons = { expanded = "", collapsed = "", current_frame = "" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        element_mappings = {},
        expand_lines = vim.fn.has("nvim-0.7") == 1,
        force_buffers = true,
        layouts = {
          {
            -- You can change the order of elements in the sidebar
            elements = {
              -- Provide IDs as strings or tables with "id" and "size" keys
              { id = "scopes", size = 0.5 },
              { id = "repl", size = 0.5 },
            },
            size = 20,
            position = "bottom",
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            ["close"] = { "q", "<Esc>" },
          },
        },
        controls = {
          enabled = false, -- vim.fn.exists("+winbar") == 1,
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
            disconnect = "",
          },
        },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
          indent = 1,
        },
      })
      -- Hover over variable to show value
      vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
        dapui.eval()
      end, { desc = "Hover variable" })
      -- vim.api.nvim_create_augroup("DapHover", { clear = true })
      -- vim.api.nvim_create_autocmd("CursorHold", {
      --   group = "DapHover",
      --   callback = function()
      --     if dap.session() then
      --       dapui.eval()
      --     end
      --   end,
      -- })
      dap.listeners.after.event_initialized.ddapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    requires = {
      {
        "Issafalcon/neotest-dotnet",
      },
    },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "Issafalcon/neotest-dotnet",
    lazy = false,
    dependencies = {
      "nvim-neotest/neotest",
    },
  },
  {
    "ramboe/ramboe-dotnet-utils",
    dependencies = { "mfussenegger/nvim-dap" },
  },
}
