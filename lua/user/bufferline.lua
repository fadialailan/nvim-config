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
	vim.keymap.set({ "n", "v" }, "<leader>bc", "<cmd>bdelete<cr>", { desc = "close current buffer" })
end
