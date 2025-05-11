return function()
	local wk = require("which-key")
	local term = "kitty"

	function CloseBufferAndSwitchToPrevious()
		local current_buf = vim.api.nvim_get_current_buf()
		local alternate_buf = vim.fn.bufnr('#') -- Get the alternate buffer ('#')

		-- Check if alternate buffer is valid and listed
		if alternate_buf ~= -1 and
		    vim.api.nvim_buf_is_valid(alternate_buf) and
		    vim.bo[alternate_buf].buflisted and
		    alternate_buf ~= current_buf then
			-- Switch to alternate buffer first to avoid E937 (can't delete current buffer)
			vim.api.nvim_set_current_buf(alternate_buf)
			vim.api.nvim_buf_delete(current_buf, {})
		else
			-- Fallback to normal :bd behavior (will close window if last buffer)
			vim.cmd('bd')
		end
	end

	-- Create command
	vim.api.nvim_create_user_command(
		'BDSmart',
		CloseBufferAndSwitchToPrevious,
		{ desc = 'Close current buffer and switch to previous buffer' }
	)

	-- Optional key mapping
	vim.keymap.set('n', '<leader>bd', CloseBufferAndSwitchToPrevious, { desc = 'Smart buffer delete' })

	wk.register({
		["<leader>"] = {
			w = { "<C-w>", "+window" },
			b = {
				name = "buffer",
				b = { "<cmd>JABSOpen<cr>", "list buffers" },
				d = { CloseBufferAndSwitchToPrevious, "delete smart" },
				n = { "<cmd>bn<cr>", "next" },
				p = { "<cmd>bp<cr>", "prev" },
				s = {
					name = "split",
					n = { "<cmd>sbn<cr>", "next" },
					p = { "<cmd>sbp<cr>", "prev" },
				},
			},
			cc = { name = "color highlighter" },
			s = { name = "session" },
			x = { name = "trouble" },
			[";"] = { "<cmd>silent !" .. term .. "&<cr>", "open term" }
		},
		["<C-j>"] = { "<cmd>move +1<cr>", "move line down" },
		["<C-k>"] = { "<cmd>move -2<cr>", "move line up" },
		["<BS>"] = { "<C-O>", "go back" },
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
	vim.api.nvim_create_user_command("SudoWrite", function(opts)
		local filename = vim.fn.shellescape(opts.args)
		if filename == "''" then
			filename = "%"
		end
		-- vim.cmd("w !sudo tee " .)
		local command = string.format("w !sudo tee %s > /dev/null", filename)
		-- print(command)
		vim.cmd(command)
		vim.cmd("e!")
	end, { nargs = "*" })
end
