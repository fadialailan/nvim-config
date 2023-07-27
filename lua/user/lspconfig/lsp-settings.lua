local M = {}


M.lua_ls = {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
			completion = {
				callSnippet = "Replace"
			}
		}
	}
}

--
--M.pylsp = {
--	settings = {
--		pylsp = {
--			configurationSources = { "flake8" },
--		},
--		plugins = {
--			autopep8 = { enabled = true },
--			flake8 = { enabled = true },
--		},
--	}
--}

M.pyright = {}

M.rust_analyzer = {
	settings = {
		['rust-analyzer'] = {
			diagnostics = {
				enable = false,
			}
		}
	}
}

M.zls = {}

return M
