return function()
	local bufferline = require("bufferline")
	bufferline.setup({
		options = {
			mode = "buffers",
			style_preset = bufferline.style_preset.default,
			numbers = "ordinal",

			close_command = "bdelete! %d",
			right_mouse_command = "bdelete! %d",
			left_mouse_command = "buffer %d",
			middle_mouse_command = nil,
			indicator = {
				icon = '▎', -- this should be omitted if indicator style is not 'icon'
				style = 'icon'
			},

			buffer_close_icon = '󰅖',
			modified_icon = '●',
			close_icon = '',
			left_trunc_marker = '',
			right_trunc_marker = '',
			offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		},
	})
	for num = 1, 9 do
		vim.keymap.set({ "n", "v" }, "<leader>" .. num,
			function() bufferline.go_to(num, true) end, { desc = "goto " .. num })
	end

	local wk = require("which-key")
	wk.register({
		["<leader>"] = {
			bl = {

				name = "buffer line",
				p = { "<cmd>BufferLinePick<cr>", "pick" },
				c = {
					name = "close",
					h = { "<cmd>BufferLineCloseLeft<cr>", "left" },
					o = { "<cmd>BufferLineCloseOthers<cr>", "others" },
					l = { "<cmd>BufferLineCloseRight<cr>", "right" },
				},
			},

			["<S-h>"] = { "<cmd>BufferLineMovePrev<cr>", "move left" },
			["<S-l>"] = { "<cmd>BufferLineMoveNext<cr>", "move right" },
		}
	})

	local hydra = require("hydra")
	hydra({
		name = "change tab",
		body = "<leader>",
		mode = { "n" },
		heads = {
			{ "l", "<cmd>BufferLineCycleNext<cr>",    { desc = "Move right" } },
			{ "h", "<cmd>BufferLineCyclePrev<cr>",    { desc = "Move left" } },
		},
	})
end
