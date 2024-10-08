return function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	local function has_words_before()
		unpack = unpack or table.unpack
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and
		    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local function cmp_tab(fallback)
		if cmp.visible() then
			cmp.select_next_item()
			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
			-- they way you will only jump inside the snippet region
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end

	local function cmp_s_tab(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end

	CmpEnabled = true

	local function is_cmp_enabled()
		return CmpEnabled
	end

	local function cmp_toggle()
		CmpEnabled = not CmpEnabled
	end

	vim.api.nvim_create_user_command("CmpToggle", cmp_toggle, {})

	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		enabled = is_cmp_enabled,
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			['<C-j>'] = cmp.mapping.select_next_item(),
			['<Tab>'] = cmp.mapping.select_next_item(),
			-- ['<Tab>'] = cmp.mapping(cmp_tab, {"i", "s"}),
			['<C-k>'] = cmp.mapping.select_prev_item(),
			-- ['<M-Tab>'] = cmp.mapping.select_prev_item(),
			['<M-Tab>'] = cmp.mapping(cmp_s_tab, {"i","s"}),
			-- ['<S-Tab>'] = cmp.mapping(cmp_s_tab, {"i","s"}),
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			--{ name = 'vsnip' }, -- For vsnip users.
			{ name = 'luasnip' }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
			{ name = "path" },
		}, {
			{ name = 'buffer' },
		})
	})
end
