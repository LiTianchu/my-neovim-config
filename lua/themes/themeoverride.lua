vim.cmd.colorscheme("tokyonight-storm")
vim.o.guifont = "JetBrainsMono Nerd Font:h10"
vim.opt.termguicolors = true

-- line number color
vim.cmd("highlight LineNr term=bold cterm=NONE ctermfg=Darkgray ctermbg=NONE gui=NONE guifg=#7ea8a7")
vim.cmd("highlight CursorLineNr term=bold cterm=NONE ctermfg=Yellow ctermbg=NONE gui=NONE guifg=Yellow guibg=#3e7075")
vim.cmd("highlight LineNrAbove term=bold cterm=NONE ctermfg=Darkgray ctermbg=NONE gui=NONE guifg=#7ea8a7")
vim.cmd("highlight LineNrBelow term=bold cterm=NONE ctermfg=Darkgray ctermbg=NONE gui=NONE guifg=#7ea8a7")

-- cursor line bg color
vim.cmd("highlight CursorLine guibg=#3e7075 ctermbg=NONE")

-- commenting color
vim.cmd("highlight Comment guifg=#819696 ctermfg=DarkGrey gui=italic cterm=italic")

if vim.g.neovide then
	-- window bg
	vim.cmd("highlight Normal guibg=#1f2224 ctermbg=NONE")

	-- floating window bg color
	vim.cmd("highlight NormalFloat guibg=#1f2224 ctermbg=NONE")
	vim.cmd("highlight DiagnosticFloating guibg=#1f2224 ctermbg=NONE")
	vim.g.neovide_opacity = 0.9
	vim.g.neovide_normal_opacity = 0.9
else
	-- window bg
	vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")

	-- floating window bg color
	vim.cmd("highlight NormalFloat guibg=NONE ctermbg=NONE")
	vim.cmd("highlight DiagnosticFloating guibg=NONE ctermbg=NONE")
end

vim.cmd("highlight FloatShadow guibg=NONE ctermbg=NONE")
vim.cmd("highlight FloatBorder guibg=NONE ctermbg=NONE")
vim.cmd("highlight FloatShadowThrough guibg=NONE ctermbg=NONE")

-- suggestion color
vim.cmd("highlight CopilotSuggestion guifg=#94b0a2 ctermfg=DarkGrey gui=italic cterm=italic")
for _, group in ipairs(vim.fn.getcompletion("Float", "highlight")) do
	vim.cmd(string.format("highlight %s guibg=NONE ctermbg=NONE", group))
end
-- Diagnostic config to have rounded border and padding
vim.diagnostic.config({
	float = {
		border = "rounded", -- or "single", "double", etc.
		focusable = true,
		source = "always",
		-- add empty lines to header/prefix for vertical/horizontal padding:
		header = "\n", -- for top padding
		prefix = "", -- for left padding
	},
})

vim.o.winborder = "rounded"
vim.g.rainbow_delimiters = {
	strategy = {
		[""] = "rainbow-delimiters.strategy.global",
		vim = "rainbow-delimiters.strategy.local",
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
	priority = {
		[""] = 110,
		lua = 210,
	},
	highlight = {
		"RainbowDelimiterRed",
		"RainbowDelimiterYellow",
		"RainbowDelimiterBlue",
		"RainbowDelimiterOrange",
		"RainbowDelimiterGreen",
		"RainbowDelimiterViolet",
		"RainbowDelimiterCyan",
	},
}

-- DAP sign colors
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e06c75" }) -- red
vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#e5c07b" }) -- yellow
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" }) -- blue
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = "#2d3b2d" }) -- green + bg highlight
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#888888" }) -- grey

vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "DapBreakpointCondition" })
vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "->", texthl = "DapStopped", linehl = "DapStopped" })
vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "DapBreakpointRejected" })
