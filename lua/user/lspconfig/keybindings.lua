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

		--normal mode
		wk.register({
			["<leader>"] = {
				c = {
					name = "code",
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
		wk.register({
			["<leader>"] = {
				c = {
					name = "code",
					a = { vim.lsp.buf.code_action, "actions" },
				}
			}
		}, nv_opts)
		--vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, n_opts)
		--vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, n_opts)
		--vim.keymap.set('n', '<leader>gh', vim.lsp.buf.hover, n_opts)
		--vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, n_opts)
		--vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, n_opts)
		--vim.keymap.set('n', '<leader>cwa', vim.lsp.buf.add_workspace_folder, n_opts)
		--vim.keyvim.keymap.set('n', '<leader>cwr', vim.lsp.buf.remove_workspace_folder, n_opts)
		--vim.keyvim.keymap.set('n', '<leader>cwl', function()
		--	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		--end, n_opts)
		--vim.keymap.set('n', '<leader>cd', vim.lsp.buf.type_definition, n_opts)
		--vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, n_opts)
		--vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, n_opts)
		--vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, n_opts)
		--vim.keymap.set('n', '<leader>cf', function()
		--	vim.lsp.buf.format { async = true }
		--end, n_opts)
	end,
})
