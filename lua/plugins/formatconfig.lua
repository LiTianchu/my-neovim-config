require("mason-null-ls").setup({
	ensure_installed = {
		"stylua", -- Lua formatter
		"prettierd", -- JS/TS formatter
		"black", -- Python formatter
		"isort", -- Python import sorter
		"markdownlint", -- Markdown linter
		"sql_formatter", -- SQL formatter
		"yamlfmt", -- YAML formatter
		"gdtoolkit", -- Godot formatter
		"gofumpt", -- Go formatter
		"shfmt", -- Shell formatter
		-- "ocamlformat", -- OCaml formatter (use opam installed version)
	},
})

local prettierFormattable = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"vue",
	"css",
	"scss",
	"less",
	"html",
	"json",
	"jsonc",
	"graphql",
	"svelte",
	"handlebars",
}

-- Linter and Formatter settings
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua, -- Lua formatter
		null_ls.builtins.completion.spell, -- spell checking
		-- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
		null_ls.builtins.formatting.prettierd.with({
			filetypes = prettierFormattable,
		}), -- JS/TS formatter
		null_ls.builtins.formatting.black.with({
			extra_args = { "--fast" },
		}),
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.markdownlint,
		null_ls.builtins.formatting.sql_formatter,
		null_ls.builtins.formatting.yamlfmt,
		null_ls.builtins.formatting.gdformat,
		null_ls.builtins.diagnostics.gdlint,
		null_ls.builtins.formatting.gofumpt,
	},
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = prettierFormattable,
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.softtabstop = 2
		vim.bo.expandtab = true
	end,
})

-- Format on save for multiple languages
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = {
		-- Web
		"*.ts",
		"*.tsx",
		"*.js",
		"*.jsx",
		"*.vue",
		"*.html",
		"*.css",
		"*.scss",
		"*.less",
		"*.svelte",

		-- Data
		"*.sql",
		"*.json",
		"*.jsonc",
		"*.yaml",
		"*.yml",
		"*.graphql",
		"*.gql",

		-- Systems / Backend
		"*.c",
		"*.cpp",
		"*.h",
		"*.hpp",
		"*.rs",
		"*.java",
		"*.cs",
		"*.py",
		"*.go",

		-- Scripting
		"*.lua",
		"*.sh",
		"*.bash",

		-- Documentation
		"*.md",

		-- Functional
		"*.ml",
		"*.mli",
		"*.hs",
		"*.lhs",

		-- Game Dev
		"*.gd",
		"*.odin",
	},
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
