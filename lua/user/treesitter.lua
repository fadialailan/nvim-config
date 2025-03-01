return function()
	local treesitter = require("nvim-treesitter.configs")
	local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

	treesitter.setup({
		-- A list of parser names, or "all"
		-- ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "rust", "zig" },

		--[[ ensure_installed = {
		    'astro','c', 'css', 'glimmer', 'graphql', 'handlebars', 'html', 'javascript',
		    'lua', 'nix', 'php', 'python', 'rescript',"rust", 'scss', 'svelte', 'tsx', 'twig',
		    'typescript', 'vim',"vimdoc", 'vue',"rust",
		  }, ]]
		ensure_installed = {
			'astro', 'c', 'css', 'glimmer', 'graphql', 'html', 'javascript',
			'lua', 'nix', 'php', 'python', "rust", 'scss', 'svelte', 'tsx', 'twig',
			'typescript', 'vim', "vimdoc", 'vue', "rust",
		},
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
			disable = {
				"ini", -- the highlighting for comments is confusing
			},
			additional_vim_regex_highlighting = false,
		},
		modules = { "highlight, indent, incremental_selection" },

		indent = {
			enable = true,
		},

		incremental_selection = {
			enable = true,
		},

		-- for nvim-ts-context-commentstring
		-- context_commentstring = {
		-- 	enable = true,
		-- 	enable_autocmd = false,
		-- },
	})

	require("ts_context_commentstring").setup({
		enable_autocmd = false,
	})

	vim.filetype.add({
		extension = {
			c3 = "c3",
			c3i = "c3",
			c3t = "c3",
		},
	})

	parser_config.c3 = {
		install_info = {
			url = "https://github.com/c3lang/tree-sitter-c3",
			files = { "src/parser.c", "src/scanner.c" },
			branch = "main",
		},
	}

	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	vim.cmd(":set nofoldenable")
end
