return function ()
	local wk = require("which-key")
	local builtin = require('telescope.builtin')

	wk.register({
		["<leader>"] = {
			f = {
				name = "find",
				f = { builtin.find_files, "find files" },
				g = { builtin.live_grep, "grep" },
				b = { builtin.buffers, "buffers"},
				h = { builtin.help_tags, "help tags" },
			}
		}
	},{})
end
