return function()
	--local util = require("formatter.util")
	local formatter = require("formatter")

	formatter.setup({

		logging = true,
		-- Set the log level
		log_level = vim.log.levels.WARN,
		-- All formatter configurations are opt-in
		filetype = {
			python = {
				function()
					return {
						exe = "autopep8",
						args = {
							"-"
						},
						stdin = true,
					}
				end
			}
		},
	})

	vim.keymap.set("n", "<leader>cF", "<cmd>Format<cr>", { desc="format"})
end