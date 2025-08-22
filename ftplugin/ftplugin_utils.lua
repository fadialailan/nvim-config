local M = {}

M.set_indent_with_spaces = function (tab_size)
	if tab_size == nil then
		tab_size = 4
	end
	vim.opt.expandtab = true
	vim.opt.tabstop = tab_size
	vim.opt.softtabstop = tab_size
	vim.opt.shiftwidth = tab_size
end

return M
