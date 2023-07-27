local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{ "folke/neodev.nvim",  config = require("user/neodev") },
	{
		"sainnhe/sonokai",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme sonokai")
		end
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"folke/which-key.nvim"
		},
		config = require("user/lspconfig")
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip"
		},
		config = require("user/nvim-cmp"),
		lazy = false
	},
	{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
	{ "saadparwaiz1/cmp_luasnip" },
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = require("user/telescope")
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = require("user/keybindings")
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = { ":TSUpdate" },
		config = require("user/treesitter"),
	},
	{
		"mhartington/formatter.nvim",
		config = require("user/formatter"),
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {} -- this is equalent to setup({}) function
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		opts = {},
	}, {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	},
	require("user/nvim-tree"),
})

