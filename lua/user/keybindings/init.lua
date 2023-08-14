return function()
	local wk = require("which-key")
	local term = "kitty"

	wk.register({
		["<leader>"] = {
			w = { "<C-w>", "+window" },
			b = {
				name = "buffer",
				b = { "<cmd>JABSOpen<cr>", "list buffers" },
				d = { "<cmd>bd<cr>", "delete" },
				n = { "<cmd>bn<cr>", "next" },
				p = { "<cmd>bp<cr>", "prev" },
				s = {
					name = "split",
					n = { "<cmd>sbn<cr>", "next" },
					p = { "<cmd>sbp<cr>", "prev" },
				},
			},
			s = { name = "session" },
			x = { name = "trouble" },
			[";"] = { "<cmd>silent !" .. term .. "&<cr>", "open term" }
		},
		["<C-j>"] = { "<cmd>move +1<cr>", "move line down" },
		["<C-k>"] = { "<cmd>move -2<cr>", "move line up" },
	})

	wk.register({
		["<leader>"] = {
			y = { "\"+y", "clip yank" },
			p = { "\"+p", "clip put" },
			P = { "\"+P", "clip put after" },
		}
	}, { mode = { "n", "v" } })

	wk.register({
		["<C-j>"] = { ":move '>+1<cr>gv", "move region down" },
		["<C-k>"] = { ":move '<-2<cr>gv", "move region up" },
		["."] = { ">gv", "indent" },
		[","] = { "<gv", "remove indent" },
	}, { mode = { "v" } })


	--[[ wk.register({
	}, { mode = { "i" } }) ]]
end
