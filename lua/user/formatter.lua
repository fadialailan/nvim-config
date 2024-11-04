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
			},
			html = {
				function()
					return {
						exe = "tidy",
						args = {
							"--indent",
							"yes",
							"--indent-spaces",
							"4",
							"-",
						},
						stdin = true,
					}
				end
			},
			xml = {
				function ()
					return {
						exe = "xmllint",
						args = {
							"--format",
							"-"
						},
						stdin = true,
					}
				end
			},
			json = {
				function ()
					return {
						exe = "jq",
						stdin = true,
					}
				end
			},
			markdown = {
				function ()
					return {
						exe = "mdformat",
						args = {
							"--wrap",
							"70"
						}
					}
				end
			}
		},
	})

	vim.keymap.set("n", "<leader>cF", "<cmd>Format<cr>", { desc="format"})
end
