return function()
	local wk = require("which-key")

	wk.register({
		["<leader>"] = {
			w = { "<C-w>", "+window" },
			b = {
				name = "buffer",
				d = { "<cmd>bd<cr>", "delete" },
				n = { "<cmd>bn<cr>", "next" },
				p = { "<cmd>bp<cr>", "prev" },
				b = { "<cmd>Telescope buffers<cr>", "prev" },
				s = {
					name = "split",
					n = { "<cmd>sbn<cr>", "next" },
					p = { "<cmd>sbp<cr>", "prev" },
				}
			}
		}
	})

	wk.register({
		["<leader>"] = {
			y = { "\"+y", "clip yank" },
			p = { "\"+p", "clip put" },
			P = { "\"+P", "clip put after" },
		}
	}, { mode = { "n", "v" } })
end
