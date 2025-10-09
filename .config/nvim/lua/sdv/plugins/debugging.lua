return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
    },
    config = function()
      local dap = require("dap")

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
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return require("dap-dll-autopicker").build_dll_path()
          end,
          -- justMyCode = false,
          -- stopAtEntry = false,
          -- -- program = function()
          -- --   -- todo: request input from ui
          -- --   return "/path/to/your.dll"
          -- -- end,
          -- env = {
          --   ASPNETCORE_ENVIRONMENT = function()
          --     -- todo: request input from ui
          --     return "Development"
          --   end,
          --   ASPNETCORE_URLS = function()
          --     -- todo: request input from ui
          --     return "http://localhost:5050"
          --   end,
          -- },
          -- cwd = function()
          --   -- todo: request input from ui
          --   return vim.fn.getcwd()
          -- end,
        },
      }

      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

      local map = vim.keymap.set

      map("n", "<F5>", dap.continue, { noremap = true, silent = true, desc = "Run in debug mode" })
      map("n", "<F9>", dap.toggle_breakpoint, { noremap = true, silent = true, desc = "Toggle breakpoint" })
      map("n", "<F10>", dap.step_over, { noremap = true, silent = true, desc = "Step over" })
      map("n", "<F11>", dap.step_into, { noremap = true, silent = true, desc = "Step into" })
      map("n", "<F8>", dap.step_out, { noremap = true, silent = true, desc = "Step out" })
      map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      map("n", "<leader>dc", dap.clear_breakpoints, { desc = "Clear all breakpoints" })
      map("n", "<leader>dr", dap.repl.open, { noremap = true, silent = true, desc = "Open REPL" })
      -- todo: sdv find out what run last does.
      map("n", "<leader>dl", dap.run_last, { noremap = true, silent = true, desc = "Run last ???" })

      map(
        "n",
        "<leader>dt",
        "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>",
        { noremap = true, silent = true, desc = "Debug nearest test" }
      )
      vim.keymap.set("n", "<leader>dX", dap.terminate, { desc = "Terminates the debug session" })
      vim.keymap.set("n", "<leader>dx", dap.disconnect, { desc = "Disconect from the debug session" })

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
              {
                id = "scopes",
                size = 0.5, -- Can be float or integer > 1
              },
              --{ id = "watches", size = 0.33 },
              { id = "repl", size = 0.5 },
            },
            size = 40,
            position = "right", -- Can be "left" or "right"
          },
          -- {
          -- 	elements = {
          -- 		"console",
          -- 	},
          -- 	size = 12,
          -- 	position = "bottom", -- Can be "bottom" or "top"
          -- },
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
          enabled = vim.fn.exists("+winbar") == 1,
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

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      -- The following line was seeb in ramboe's setup vid. Prob not needed unless open issues.
      --dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
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
