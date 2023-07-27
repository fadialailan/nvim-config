vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.timeoutlen = 500
vim.opt.switchbuf = "vsplit"
vim.g.mapleader = " "
vim.g.confirm = true

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

--shift lines
vim.api.nvim_set_keymap("n", "<C-j>", "<cmd>move +1<cr>", {})
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>move -2<cr>", {})
--shift regions
vim.api.nvim_set_keymap("v", "<C-j>", ":move '>+1<cr>gv", {})
vim.api.nvim_set_keymap("v", "<C-k>", ":move '<-2<cr>gv", {})

--exit insert mode
vim.keymap.set({ "i" }, "jj", "<Esc>", {})
