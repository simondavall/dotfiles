return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		dapui.setup()
		require("dap-go").setup()

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

		vim.keymap.set("n", "<leader>dd", dap.continue, { desc = "Run in debug mode" })
		vim.keymap.set("n", "<leader>d1", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<leader>d2", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<leader>d3", dap.step_out, { desc = "Step out of" })
		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<Leader>dB", dap.set_breakpoint, { desc = "Set breakpoint" })
		-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
		-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
		-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
		-- vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
		--   require('dap.ui.widgets').hover()
		-- end)
		-- vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
		--   require('dap.ui.widgets').preview()
		-- end)
		-- vim.keymap.set('n', '<Leader>df', function()
		--   local widgets = require('dap.ui.widgets')
		--   widgets.centered_float(widgets.frames)
		-- end)
		-- vim.keymap.set('n', '<Leader>ds', function()
		--   local widgets = require('dap.ui.widgets')
		--   widgets.centered_float(widgets.scopes)
		-- end)
	end,
}
