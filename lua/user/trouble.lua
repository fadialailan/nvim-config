return {
	"folke/trouble.nvim",
	config = function ()
		local trouble = require("trouble")
		trouble.setup({})
		vim.keymap.set("n", "<leader>xx", function() trouble.open() end, {desc ="open"})
		vim.keymap.set("n", "<leader>xd", function() trouble.open("symbols") end, {desc ="document symbols"})
		vim.keymap.set("n", "<leader>xw", function() trouble.open("diagnostics") end, {desc ="workspace"})
		vim.keymap.set("n", "<leader>xq", function() trouble.open("quickfix") end, {desc ="quickfix"})
		vim.keymap.set("n", "<leader>xl", function() trouble.open("loclist") end, {desc ="loclist"})
		vim.keymap.set("n", "<leader>xr", function() trouble.open("lsp_references") end, {desc ="lsp ref"})
		vim.keymap.set("n", "<leader>xt", function() trouble.open("todo") end, {desc ="todo"})
	end
}
