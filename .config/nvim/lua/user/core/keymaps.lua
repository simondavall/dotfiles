vim.g.mapleader = " " -- set leader key to space

local keymap = vim.keymap

-----------------------
--- General Keymaps ---
-----------------------

-- use jk / kj to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
-- OLD to be removed - keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
-- Cancel search highlighting with ESC
keymap.set({ "n" }, "<ESC>", ":nohl<CR><ESC>", { desc = "Clear search highlights and ESC" })

-- increment/decrement numbers
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })

-- window management
-- keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
-- keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
-- keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>w-", ":split<CR>", { desc = "Horizontal split" })
keymap.set("n", "<leader>w|", ":vsplit<CR>", { desc = "Vertical split" })
keymap.set("n", "<leader>wq", ":close<CR>", { desc = "Close split" })
--keymap.set("n", "<leader>wT", "<cmd>wincmd T<cr>", { desc = "Move window to new tab" })
keymap.set("n", "<leader>wr", "<cmd>wincmd r<cr>", { desc = "rotate down/right" })
keymap.set("n", "<leader>wR", "<cmd>wincmd R<cr>", { desc = "rotate up/left" })
--keymap.set("n", "<leader>wH", "<cmd>wincmd H<cr>", { desc = "Move left" })
--keymap.set("n", "<leader>wJ", "<cmd>wincmd J<cr>", { desc = "Move down" })
--keymap.set("n", "<leader>wK", "<cmd>wincmd K<cr>", { desc = "Move up" })
--keymap.set("n", "<leader>wL", "<cmd>wincmd L<cr>", { desc = "Move right" })
--keymap.set("n", "<leader>w=", "<cmd>wincmd =<cr>", { desc = "Equalize size" })
--keymap.set("n", "<leader>wk", "<cmd>resize +5<cr>", { desc = "Up" })
--keymap.set("n", "<leader>wj", "<cmd>resize -5<cr>", { desc = "Down" })
--keymap.set("n", "<leader>wh", "<cmd>vertical resize +3<cr>", { desc = "Left" })
--keymap.set("n", "<leader>wl", "<cmd>vertical resizce -3<cr>", { desc = "Right" })


keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", ":tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- buffer management
keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "Go to previous buffer" })

--keymap.set("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
--keymap.set("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
--keymap.set("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all but the current buffer" })
--keymap.set("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Close buffer" })
--keymap.set("n", "<leader><tab>", "<cmd>b#<cr>", { desc = "Previously openend Buffer" })

-- move text
keymap.set("n", "<A-k>",    ":m .-2<CR>==") -- move line up(n)
keymap.set("n", "<A-j>",    ":m .+1<CR>==") -- move line down(n)
keymap.set("n", "<A-Up>",   ":m .-2<CR>==") -- move line up(n)
keymap.set("n", "<A-Down>", ":m .+1<CR>==") -- move line down(n)
keymap.set("v", "<A-k>",    ":m '<-2<CR>gv=gv") -- move text block up(v)
keymap.set("v", "<A-j>",    ":m '>+1<CR>gv=gv") -- move text block down(v)
keymap.set("v", "<A-Up>",   ":m '<-2<CR>gv=gv") -- move text block up(v)
keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv") -- move text block down(v)
keymap.set("v", "<A-Left>", "<gv") -- move text block left
keymap.set("v", "<A-Right>", ">gv") -- move text block right

-- Remap for dealing with visual line wraps
--keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
--keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- paste over currently selected text without yanking it
keymap.set("v", "p", '"_dp')
keymap.set("v", "P", '"_dP')

-- save like your are used to
keymap.set({ "v", "n", "s" }, "<C-s>", ":w<CR><ESC>", { desc = "Save file" })
keymap.set({ "i" }, "<C-s>", "<ESC>:w<CR>", { desc = "Save file" })
keymap.set({ "v", "n", "s" }, "<C-s>a", ":wa<CR><ESC>", { desc = "Save all files" })
keymap.set({ "i" }, "<C-s>a", "<ESC>:wa<CR>", { desc = "Save all files" })

-- quitting nvim
keymap.set({ "n", "v" }, "<leader>q", ":q", { desc = "Quit nvim" })
keymap.set({ "n", "v" }, "<leader>qa", ":qa", { desc = "Quit all nvim" })
keymap.set({ "n", "v" }, "<leader>q!", ":q!", { desc = "Quit nvim without saving!" })
keymap.set({ "n", "v" }, "<leader>qa!", ":qa!", { desc = "Quit all nvim without saving!" })

