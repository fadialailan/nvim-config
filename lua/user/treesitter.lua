return function()
	local treesitter = require("nvim-treesitter.configs")

	treesitter.setup({
		-- A list of parser names, or "all"
		ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "rust", "zig" },
		--ensure_installed = "all"

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		-- List of parsers to ignore installing (for "all")
		ignore_install = {},

		highlight = {
			enable = true,

			additional_vim_regex_highlighting = false,
		},
		modules = { "highlight, indent, incremental_selection" },

		indent = {
			enable = true,
		},

		incremental_selection = {
			enable = true,
		}
	})

	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	vim.cmd(":set nofoldenable")
end
