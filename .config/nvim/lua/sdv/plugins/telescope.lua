return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string in cwd, get results as you type" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find in open buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find in available help tags" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find in recent files" })
		vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in cwd" })
		vim.keymap.set("n", "<leader>fo", builtin.vim_options, { desc = "Find vim options" })
		vim.keymap.set("n", "<leader>fp", builtin.planets, { desc = "Use the telescope..." })
		vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Find tiems in quickfix list" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find key mappings" })
		vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

		-- look into adding telescope LSP search capabilities.
		-- https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#neovim-lsp-pickers
	end,
}
