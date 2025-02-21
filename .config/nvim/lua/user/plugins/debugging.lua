return {
	{
		-- "mfussenegger/nvim-dap",
		-- dependencies = {
		-- 	"nvim-neotest/nvim-nio",
		-- 	"rcarriga/nvim-dap-ui",
		-- },
		-- config = function()
		-- 	local dap = require("dap")
		-- 	vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
		-- 	vim.keymap.set("n", "<leader>dd", dap.continue, { desc = "Run in debug mode" })
		-- 	vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminates the debug session" })
		-- 	vim.keymap.set("n", "<leader>dx", dap.disconnect, { desc = "Disconect from the debug session" })
		-- 	vim.keymap.set("n", "1", dap.step_over, { desc = "Step over" })
		-- 	vim.keymap.set("n", "2", dap.step_into, { desc = "Step into" })
		-- 	vim.keymap.set("n", "3", dap.step_out, { desc = "Step out of" })
		-- 	vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		-- 	vim.keymap.set("n", "<leader>dB", dap.set_breakpoint, { desc = "Set breakpoint" })
		-- 	vim.keymap.set("n", "<leader>dc", dap.clear_breakpoints, { desc = "Clear all breakpoints" })
		-- 	-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
		-- 	--vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL window" })
		-- 	-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
		--
		-- end,
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
			vim.keymap.set("n", "<leader>dd", dap.continue, { desc = "Run in debug mode" })
			vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminates the debug session" })
			vim.keymap.set("n", "<leader>dx", dap.disconnect, { desc = "Disconect from the debug session" })
			vim.keymap.set("n", "<leader>d1", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<leader>d2", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<leader>d3", dap.step_out, { desc = "Step out of" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dB", dap.set_breakpoint, { desc = "Set breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.clear_breakpoints, { desc = "Clear all breakpoints" })
			-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
			--vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL window" })
			-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
			--
			require("dap-go").setup()
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
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
