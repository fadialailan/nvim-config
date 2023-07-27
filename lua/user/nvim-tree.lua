return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {"nvim-tree/nvim-web-devicons"},
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

			vim.keymap.set("n", "l", api.node.open.edit, opts("open"))
			vim.keymap.set("n", "t", api.tree.change_root_to_parent, opts("up"))
		end

		local nvim_tree = require("nvim-tree")

		nvim_tree.setup({
			on_attach = on_attach,
			actions = {
				open_file = {
					window_picker = {
						picker = function ()
							vim.cmd("tabnew")
							return vim.fn.win_getid()
						end
					},
				},
			},
			tab = {
				sync = {
					open = true,
					close = true,
				},
			},
		})
		vim.keymap.set("n", "<leader><leader>", function ()
			api.tree.toggle({ find_file = true, focus = true})
		end, {})
	end
}
