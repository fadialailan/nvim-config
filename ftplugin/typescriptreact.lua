--- code for detecting if other ftplugin has been loaded

-- local did_ftplugin_number = vim.fn.exists("b:did_ftplugin")
-- if did_ftplugin_number == 1 then
-- 	return
-- end

-- disable default plugin
vim.b.did_ftplugin = 1


vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 0
