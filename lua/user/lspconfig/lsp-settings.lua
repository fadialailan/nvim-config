local util = require("lspconfig.util")

local M = {}

local function or_pwd(func)
	return function(filename)
		local default_root_dir_value = func(filename)
		local pwd = vim.fn.getcwd()
		return default_root_dir_value or pwd
	end
end

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
				checkThirdParty = false,
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

M.serve_d = {
	--[[ root_dir = function (filename)
		local default_root_dir_value = util.root_pattern("dub.json", "dub.sdl", ".git")(filename)
		local pwd = vim.fn.getcwd()
		return default_root_dir_value or pwd
	end ]]
	root_dir = or_pwd(util.root_pattern("dub.json", "dub.sdl", ".git"))
}

M.jdtls = {}

M.ccls = {
	init_options = {
		cache = {
			directory = ".ccls-cache",
		},
	},
}

M.html = {}

local tsserver_capabilities = vim.lsp.protocol.make_client_capabilities()

tsserver_capabilities.textDocument.completion.completionItem.snippetSupport = true

M.tsserver = {
	capabilities = tsserver_capabilities,
}

M.texlab = {}

return M
