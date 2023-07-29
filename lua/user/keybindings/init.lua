return function()
	local wk = require("which-key")

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
				}
			}
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
	}, { mode = { "v" } })


	wk.register({
		qq = {"<Esc>", "Esc"},
	}, { mode = { "i" } })
end
