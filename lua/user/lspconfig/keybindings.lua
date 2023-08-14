-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		local wk = require("which-key")
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local n_opts = { buffer = ev.buf }
		local nv_opts = { mode = { "n", "v" }, buffer = ev.buf }
		local ni_opts = { mode = { "n", "i" }, buffer = ev.buf }

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
			["<c-s>"] = { vim.lsp.buf.signature_help, "signature help" }
		}, ni_opts)
	end,
})
