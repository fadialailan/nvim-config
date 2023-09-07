vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.timeoutlen = 500
vim.opt.switchbuf = "vsplit"
vim.g.mapleader = " "
vim.g.confirm = true
vim.opt.wrap = false
vim.opt.termguicolors = true

-- testing
vim.opt.updatetime = 100

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- do not fold everything from the start
vim.opt.foldlevelstart = 99

-- go down based on screen line and file line (for wrapping)
vim.keymap.set({"v", "n"}, "j", "gj")
vim.keymap.set({"v", "n"}, "k", "gk")

-- markers
vim.cmd("highlight IndentBlanklineContextChar guifg=#FFFFFF gui=nocombine")
vim.opt.list = true
vim.opt.listchars:append "eol:↴"

