return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local api = require("nvim-tree.api")
		local function on_attach(bufnr)
			local function opts(desc)
				return {
					desc = "nvim-tree: " .. desc,
					buffer = bufnr,
					noremap = true,
					silent = true,
					nowait = true
				}
			end
			api.config.mappings.default_on_attach(bufnr)

			vim.keymap.set("n", "l", api.node.open.edit, opts("open"))
			vim.keymap.set("n", "t", api.tree.change_root_to_parent, opts("up"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("help"))
		end

		local nvim_tree = require("nvim-tree")

		nvim_tree.setup({
			on_attach = on_attach,
			actions = {
				open_file = {
					window_picker = {
						enable = false,
						picker = function()
							vim.cmd("tabnew")
							return vim.fn.win_getid()
						end
					},
				},
			},
			filters = {
				git_ignored = false,
			},
			tab = {
				sync = {
					open = true,
					close = true,
				},
			},
		})
		vim.keymap.set("n", "<leader><leader>", function()
			api.tree.toggle({ find_file = true, focus = true })
		end, {})
	end
}
