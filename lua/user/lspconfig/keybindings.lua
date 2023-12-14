-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable lsp overload
		--- Guard against servers without the signatureHelper capability
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client.server_capabilities.signatureHelpProvider then
			require('lsp-overloads').setup(client,
				{
					-- UI options are mostly the same as those passed to vim.lsp.util.open_floating_preview
					ui = {
						border = "single", -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
						height = nil, -- Height of the signature popup window (nil allows dynamic sizing based on content of the help)
						width = nil, -- Width of the signature popup window (nil allows dynamic sizing based on content of the help)
						wrap = true, -- Wrap long lines
						wrap_at = nil, -- Character to wrap at for computing height when wrap enabled
						max_width = nil, -- Maximum signature popup width
						max_height = nil, -- Maximum signature popup height
						-- Events that will close the signature popup window: use {"CursorMoved", "CursorMovedI", "InsertCharPre"} to hide the window when typing
						close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
						focusable = true, -- Make the popup float focusable
						focus = false, -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
						offset_x = 0, -- Horizontal offset of the floating window relative to the cursor position
						offset_y = 0, -- Vertical offset of the floating window relative to the cursor position
						floating_window_above_cur_line = false, -- Attempt to float the popup above the cursor position
						-- (note, if the height of the float would be greater than the space left above the cursor, it will default
						-- to placing the float below the cursor. The max_height option allows for finer tuning of this)
						silent = true -- Prevents noisy notifications (make false to help debug why signature isn't working)
					},
					keymaps = {
						next_signature = "<C-j>",
						previous_signature = "<C-k>",
						next_parameter = "<C-l>",
						previous_parameter = "<C-h>",
						close_signature = "<A-s>"
					},
					display_automatically = false, -- Uses trigger characters to automatically display the signature overloads when typing a method signature
					silent = true,

				}
			)
		end
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		local wk = require("which-key")
		-- Buffer local mappings.
		local n_opts = { buffer = ev.buf }
		local nv_opts = { mode = { "n", "v" }, buffer = ev.buf }
		local ni_opts = { mode = { "n", "i" }, buffer = ev.buf }

		-- See `:help vim.lsp.*` for documentation on any of the below functions
		--normal mode
		wk.register({
			["<leader>"] = {
				c = {
					name = "code",
					b = {
						name = "buffer",
						s = { "<cmd>SymbolsOutline<cr>", "symbols" },
					},
					d = { vim.lsp.buf.definition, "definition" },
					D = { vim.lsp.buf.declaration, "declaration" },
					f = { function()
						vim.lsp.buf.format { async = true }
					end, "format (LSP)" },
					h = { vim.lsp.buf.hover, "hover" },
					i = { vim.lsp.buf.implementation, "implementation" },
					r = {
						n = { vim.lsp.buf.rename, "rename" },
						r = { vim.lsp.buf.references, "references" }
					},
					s = { vim.lsp.buf.signature_help, "signature help" },
					t = { vim.lsp.buf.type_definition, "type definition" },
					w = {
						name = "workspace",
						a = { vim.lsp.buf.add_workspace_folder, "add folder" },
						r = { vim.lsp.buf.add_workspace_folder, "remove folder" },
						l = { function()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end, "list folders" },
					},
				}
			}
		}, n_opts)

		-- noraml and visual
		wk.register({
			["<leader>"] = {
				c = {
					name = "code",
					a = { vim.lsp.buf.code_action, "actions" },
				}
			}
		}, nv_opts)

		-- noraml and insert
		wk.register({
			["<c-s>"] = { "<cmd>LspOverloadsSignature<cr>", "signature help" },
			-- ["<c-S>"] = { vim.lsp.buf.signature_help, "signature help" },
		}, ni_opts)
	end,
})
