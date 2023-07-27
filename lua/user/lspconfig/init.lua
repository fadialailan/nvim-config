return function()
	local lspconfig = require('lspconfig')

	-- read lsp settings
	local lsp_settings = require("user/lspconfig/lsp-settings")


	for lsp_name, lsp_setting in pairs(lsp_settings) do
		lspconfig[lsp_name].setup(lsp_setting)
	end

	require("user/lspconfig/keybindings")
end
