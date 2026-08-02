require("misc.common") -- common settings and options
require("misc.keybinds") -- common keybindings

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		require("core.plenary"),
		require("core.treesitter"),
		require("themes.colorscheme"),
		require("plugins.uiimport"),
		require("plugins.editimport"),
		require("plugins.copilotimport"),
		require("plugins.lspimport"),
		require("plugins.formatimport"),
		require("agent.avante"),
		require("dap.debugger"),
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})

require("themes.themeoverride")
require("themes.iconoverride")

require("plugins.uiconfig")

require("plugins.copilotconfig")

require("plugins.lspconfig")

require("plugins.formatconfig")

require("plugins.editconfig")

require("misc.custom") -- custom behaviour and settings
