local none_ls = {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvimtools/none-ls-extras.nvim" },
}
local mason_null_ls = {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
}
return {
	none_ls,
	mason_null_ls,
}
