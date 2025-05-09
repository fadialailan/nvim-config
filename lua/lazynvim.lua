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
	-- {"neoclide/coc.nvim"},
	{ "isobit/vim-caddyfile" },
	{ "folke/neoconf.nvim",  cmd = "Neoconf" },
	{ "folke/neodev.nvim",   config = require("user/neodev") },
	{
		"sainnhe/sonokai",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme sonokai")
		end
	},
	{
		'jakewvincent/mkdnflow.nvim',
		config = function()
			require('mkdnflow').setup({
				-- Config goes here; leave blank for defaults
				modules = {
					bib = true,
					buffers = false,
					conceal = false,
					cursor = false,
					folds = true,
					foldtext = true,
					links = false,
					lists = true,
					maps = true,
					paths = false,
					tables = true,
					yaml = false,
					cmp = false
				},
				-- perspective = {
				-- 	priority = "root",
				-- 	root_tell = "index.md"
				-- },
				mappings = {
					MkdnEnter = false,
					MkdnTab = false,
					MkdnSTab = false,
					MkdnNextLink = false,
					MkdnPrevLink = false,
					MkdnNextHeading = false,
					MkdnPrevHeading = false,
					MkdnGoBack = false,
					MkdnGoForward = false,
					MkdnCreateLink = false, -- see MkdnEnter
					MkdnCreateLinkFromClipboard = false, -- see MkdnEnter
					MkdnFollowLink = false, -- see MkdnEnter
					MkdnDestroyLink = false,
					MkdnTagSpan = false,
					MkdnMoveSource = false,
					MkdnYankAnchorLink = false,
					MkdnYankFileAnchorLink = false,
					MkdnIncreaseHeading = { 'n', '+' },
					MkdnDecreaseHeading = { 'n', '-' },
					MkdnToggleToDo = { { 'n', 'v' }, '<C-Space>' },
					MkdnNewListItem = false,
					MkdnNewListItemBelowInsert = false,
					MkdnNewListItemAboveInsert = false,
					MkdnExtendList = false,
					MkdnUpdateNumbering = { 'n', '<leader>mn' },
					MkdnTableNextCell = { 'i', '<Tab>' },
					MkdnTablePrevCell = { 'i', '<S-Tab>' },
					MkdnTableNextRow = false,
					MkdnTablePrevRow = false,
					MkdnTableNewRowBelow = { 'n', '<leader>mir' },
					MkdnTableNewRowAbove = { 'n', '<leader>miR' },
					MkdnTableNewColAfter = { 'n', '<leader>mic' },
					MkdnTableNewColBefore = { 'n', '<leader>miC' },
					MkdnFoldSection = { 'n', '<leader>mf' },
					MkdnUnfoldSection = { 'n', '<leader>mF' }
				}
			})
		end
	},
	{
		"uga-rosa/ccc.nvim",
		config = function()
			vim.opt.termguicolors = true

			local ccc = require("ccc")
			local mapping = ccc.mapping

			ccc.setup({
				-- Your preferred settings
				-- Example: enable highlighter
				highlighter = {
					auto_enable = true,
					lsp = true,
				},
			})
			vim.keymap.set({ "n" }, "<leader>cct", "<cmd>CccHighlighterToggle<cr>",
				{ desc = "toggle color display" })
		end
	},
	-- {
	-- 	"rafamadriz/neon",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.neon_italic_keyword = true
	-- 		vim.g.neon_style = "doom"
	-- 		vim.cmd("colorscheme neon")
	-- 	end
	-- },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"folke/which-key.nvim",
			'Issafalcon/lsp-overloads.nvim'
		},
		config = require("user/lspconfig")
	},
	{
		'Issafalcon/lsp-overloads.nvim',
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
			"saadparwaiz1/cmp_luasnip",

			"L3MON4D3/LuaSnip",
		},
		config = require("user/nvim-cmp"),
		lazy = false
	},
	{
		"L3MON4D3/LuaSnip",
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			local ls = require("luasnip")
			vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
		end
	},
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
		dependencies = {
			'JoosepAlviste/nvim-ts-context-commentstring',
		},
	},
	{
		"mhartington/formatter.nvim",
		config = require("user/formatter"),
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt", "spectre_panel", "m4" }
		} -- this is equalent to setup({}) function
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		opts = {},
	},
	--[[ {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end,
		dependencies = {
			'JoosepAlviste/nvim-ts-context-commentstring',
		},
	}, ]]
	-- require("user.comment"),
	require("user.mininvim"),
	{
		"matbme/JABS.nvim",
		opts = {},
	},
	require("user/nvim-tree"),
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	{
		"gennaro-tedesco/nvim-possession",
		dependencies = {
			"ibhagwan/fzf-lua",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			local possession = require("nvim-possession")
			possession.setup({
				autosave = false,
				-- autoload = true,
				post_hock = function()
					require('nvim-tree').toggle(false, true)
				end
			})

			vim.keymap.set("n", "<leader>sl", function()
				possession.list()
			end, { desc = "list" })
			vim.keymap.set("n", "<leader>sn", function()
				possession.new()
			end, { desc = "new" })
			vim.keymap.set("n", "<leader>su", function()
				possession.update()
			end, { desc = "update" })
			vim.keymap.set("n", "<leader>sd", function()
				possession.delete()
			end, { desc = "delete" })
		end,
	},
	require("user/trouble"),
	-- {
	-- 	"sindrets/diffview.nvim",
	-- 	config = function()
	-- 		require("diffview").setup({})
	--
	-- 		vim.keymap.set("n", "<leader>cgD", "<cmd>DiffviewOpen<cr>", { desc = "diffview" })
	-- 	end
	-- },
	{
		"tanvirtin/vgit.nvim",
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local vgit = require("vgit");
			vgit.setup();
			vim.keymap.set("n", "<leader>cgd", vgit.project_diff_preview, { desc = "project diffview" })
			vim.keymap.set("n", "<leader>cgD", vgit.buffer_diff_preview, { desc = "buffer diffview" })
		end
	},
	{
		"gbprod/cutlass.nvim",
		opts = {
			cut_key = "m",
			registers = {
				select = "_",
				delete = "_",
				change = "_",
			},
		},
	},
	{ "windwp/nvim-ts-autotag",  opts = {}, },
	--[[ {
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.cmd("highlight IndentBlanklineContextChar guifg=#FFFFFF gui=nocombine")
			vim.opt.list = true
			vim.opt.listchars:append "eol:↴"
			require("indent_blankline").setup {
				show_end_of_line = true,
				show_current_context = true,
				-- show_current_context_start = true,
			}
		end
	}, ]]
	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui",    dependencies = { "mfussenegger/nvim-dap" } },
	{
		"anuvyklack/hydra.nvim",
		config = function()
			local hydra = require("hydra")
			hydra({
				name = "window resize",
				body = "<leader>wa",
				mode = { "n" },
				heads = {
					{ "l", "<C-w>>",    { desc = "increase width" } },
					{ "h", "<C-w><lt>", { desc = "decrease width" } },
					{ "k", "<C-w>+",    { desc = "increase height" } },
					{ "j", "<C-w>-",    { desc = "decrease height" } },
				},
			})
		end
	},
	{ "simrat39/symbols-outline.nvim", opts = {} },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{ "elkowar/yuck.vim" },
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			"folke/which-key.nvim",
			"anuvyklack/hydra.nvim",
		},
		config = require("user/bufferline")
	},
	{
		"0oAstro/dim.lua",
		dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
	},
})
