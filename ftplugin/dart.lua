local config_path = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config/nvim")

package.path = config_path .. "/ftplugin/?.lua;" .. package.path
local utils = require("ftplugin_utils")

utils.set_indent_with_spaces(2)
