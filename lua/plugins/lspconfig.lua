require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls", -- Lua
		"ts_ls", -- Typescript
		"cssls", -- CSS
		"tailwindcss", -- Tailwind
		"html", -- HTML
		"svelte", -- Svelte
		"omnisharp", -- C#
		"rust_analyzer", -- Rust
		"pyright", -- Python
		"clangd", -- C/C++
		"jdtls", -- Java
		"yamlls", -- YAML
		"jsonls", -- JSON
		"dockerls", -- Docker
		"sqlls", -- SQL
		"graphql", -- GraphQL
		"marksman", -- Markdown
		"eslint", -- ESLint
		"bashls", -- Bash
		"prismals", -- Prisma
		"gopls", -- Go
		-- "ocamllsp", -- OCaml (handled seprately to use opam)
	},
})

require("mason-null-ls").setup({
	ensure_installed = {
		"stylua", -- Lua formatter
		-- "eslint_d", -- JS/TS linter use eslint lsp instead
		"prettierd", -- JS/TS formatter
		"black", -- Python formatter
		"isort", -- Python import sorter
		-- "clang_format", -- C/C++ formatter (use clangd lsp instead)
		"markdownlint", -- Markdown linter
		"sql_formatter", -- SQL formatter
		"yamlfmt", -- YAML formatter
		"gdtoolkit", -- Godot formatter
		"goimports", -- Go formatter and import organizer
		-- "csharpier", -- C# formatter (use omnisharp lsp instead)
		-- "ocamlformat", -- OCaml formatter (use opam installed version)
	},
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- LSP settings for various languages
-- Lua
vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
	on_attach = function(client, _)
		-- Disable lua_ls formatting, use stylua
		client.server_capabilities.documentFormattingProvider = false
	end,
})

vim.lsp.enable("lua_ls")

-- CSS
vim.lsp.config("cssls", {
	capabilities = capabilities,
})
vim.lsp.enable("cssls")

-- Tailwind CSS
vim.lsp.config("tailwindcss", {
	settings = {
		tailwindCSS = {
			includeLanguages = {
				typescript = "javascript",
				typescriptreact = "javascript",
				html = "html",
				css = "css",
				svelte = "html",
				vue = "html",
			},
		},
	},
	capabilities = capabilities,
})

vim.lsp.enable("tailwindcss")

-- TypeScript/JavaScript
vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
	on_attach = function(client, _)
		-- Disable ts_ls formatting, use prettierd instead
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
})
vim.lsp.enable("ts_ls")

-- Svelte
vim.lsp.config("svelte", {
	capabilities = capabilities,
	filetypes = { "svelte" },
	settings = {
		svelte = {
			plugin = {
				typescript = { enable = true },
				css = { enable = true },
				svelte = { format = { enable = false } }, -- Disable built-in formatter to use prettierd
			},
		},
	},
})
vim.lsp.enable("svelte")

-- Rust
vim.lsp.config("rust_analyzer", {
	capabilities = capabilities,
})
vim.lsp.enable("rust_analyzer")

-- C#
vim.lsp.config("omnisharp", {
	capabilities = capabilities,
})
vim.lsp.enable("omnisharp")

-- HTML
vim.lsp.config("html", {
	capabilities = capabilities,
})
vim.lsp.enable("html")

-- Python
vim.lsp.config("pyright", {
	capabilities = capabilities,
})
vim.lsp.enable("pyright")

-- C/C++
vim.lsp.config("clangd", {
	capabilities = capabilities,
})
vim.lsp.enable("clangd")

-- Java
vim.lsp.config("jdtls", {
	capabilities = capabilities,
})
vim.lsp.enable("jdtls")

-- YAML
vim.lsp.config("yamlls", {
	capabilities = capabilities,
})
vim.lsp.enable("yamlls")

-- JSON
vim.lsp.config("jsonls", {
	capabilities = capabilities,
})
vim.lsp.enable("jsonls")

-- Docker
vim.lsp.config("dockerls", {
	capabilities = capabilities,
})
vim.lsp.enable("dockerls")

-- SQL
vim.lsp.config("sqlls", {
	capabilities = capabilities,
})
vim.lsp.enable("sqlls")

-- GraphQL
vim.lsp.config("graphql", {
	capabilities = capabilities,
})
vim.lsp.enable("graphql")

-- Markdown
vim.lsp.config("marksman", {
	capabilities = capabilities,
})
vim.lsp.enable("marksman")

-- ESLint
vim.lsp.config("eslint", {
	capabilities = capabilities,
	settings = {
		experimental = {
			useFlatConfig = true, -- Set this to true for eslint.config.js
		},
	},
})
vim.lsp.enable("eslint")

-- Bash
vim.lsp.config("bashls", {
	capabilities = capabilities,
})
vim.lsp.enable("bashls")
vim.lsp.config("ocaml-lsp", {
	-- It forces the command to be run through OPAM.
	-- OPAM will execute 'ocamllsp' using the environment of the *active* switch,
	-- which should be your OCaml 4.14 switch where you installed the compatible LSP.
	cmd = { "opam", "exec", "--", "ocamllsp" },
	filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
	capabilities = capabilities,
})

vim.lsp.enable("ocaml-lsp")

local function godot_lsp_cmd()
	if vim.fn.has("win32") == 1 then
		return { "ncat", "localhost", "6005" }
	else
		return vim.lsp.rpc.connect("127.0.0.1", 6005)
	end
end

local gdscript_config = {
	capabilities = capabilities,
	cmd = godot_lsp_cmd(),
	filetypes = { "gdscript", "gd" },
	root_dir = function(bufnr, cb)
		cb(vim.fs.root(bufnr, { "project.godot", ".git" }))
	end,
}

vim.lsp.config("gdscript", gdscript_config)
vim.lsp.enable("gdscript")

vim.lsp.config("gopls", {
	capabilities = capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
})
vim.lsp.enable("gopls")

-- Linter and Formatter settings
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua, -- Lua formatter
		null_ls.builtins.completion.spell, -- spell checking
		-- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
		null_ls.builtins.formatting.prettierd.with({
			filetypes = {
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
			},
		}), -- JS/TS formatter
		null_ls.builtins.formatting.black.with({
			extra_args = { "--fast" },
		}),
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.markdownlint,
		null_ls.builtins.formatting.sql_formatter,
		null_ls.builtins.formatting.yamlfmt,
		null_ls.builtins.formatting.gdformat,
		null_ls.builtins.formatting.goimports,
	},
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
		"*.go",
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
		"*.sql",

		-- OCaml
		"*.ml",
		"*.mli",

		-- Game Dev
		"*.gd",
	},
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
