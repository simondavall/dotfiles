return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			vim.keymap.set("n", "<leader>dd", dap.continue, { desc = "Run in debug mode" })
			vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminates the debug session" })
			vim.keymap.set("n", "<leader>dx", dap.disconnect, { desc = "Disconect from the debug session" })
			vim.keymap.set("n", "<leader>d1", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<leader>d2", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<leader>d3", dap.step_out, { desc = "Step out of" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dB", dap.set_breakpoint, { desc = "Set breakpoint" })
			-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
			vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL window" })
			-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
			local widgets = require("dap.ui.widgets")
			local sidebar = widgets.sidebar(widgets.scopes)
			vim.keymap.set("n", "<leader>ds", sidebar.open, { desc = "Open debug sidebar" })
			vim.keymap.set("n", "<leader>dc", sidebar.close, { desc = "Close debug sidebar" })
			vim.keymap.set({ "n", "v" }, "<Leader>dh", widgets.hover, { desc = "Hover" })
			vim.keymap.set({ "n", "v" }, "<Leader>dp", widgets.preview, { desc = "Preview" })
			-- vim.keymap.set('n', '<Leader>df', function()
			--   local widgets = require('dap.ui.widgets')
			--   widgets.centered_float(widgets.frames)
			-- end)
			-- vim.keymap.set('n', '<Leader>ds', function()
			--   local widgets = require('dap.ui.widgets')
			--   widgets.centeredsidebar)
			-- end)
			dap.listeners.before.attach.dapui_config = sidebar.open
			dap.listeners.before.launch.dapui_config = sidebar.open
			dap.listeners.before.event_terminated.dapui_config = sidebar.close
			dap.listeners.before.event_exited.dapui_config = sidebar.close
		end,
	},
	{
		"leoluz/nvim-dap-go",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function(_, opts)
			require("dap-go").setup(opts)
		end,
	},
}
