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
			cc = {name = "color highlighter"},
			s = { name = "session" },
			x = { name = "trouble" },
			[";"] = { "<cmd>silent !" .. term .. "&<cr>", "open term" }
		},
		["<C-j>"] = { "<cmd>move +1<cr>", "move line down" },
		["<C-k>"] = { "<cmd>move -2<cr>", "move line up" },
		["<BS>"] = {"<C-O>", "go back"},
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

	-- commands
	vim.api.nvim_create_user_command("SudoWrite", function (opts)
		local filename = vim.fn.shellescape( opts.args)
		if filename == "''" then
			filename = "%"
		end
		-- vim.cmd("w !sudo tee " .)
		local command = string.format("w !sudo tee %s > /dev/null", filename)
		-- print(command)
		vim.cmd(command)
		vim.cmd("e!")
	end, {nargs="*"})
end
