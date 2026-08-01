return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "TSUpdate",
			callback = function()
				require("nvim-treesitter.parsers").ron = {
					install_info = {
						url = "https://github.com/zee-editor/tree-sitter-ron",
						branch = "main",
						queries = "queries", -- pull queries from this dir in the repo
					},
				}
			end,
		})

		-- addtional filetypes
		vim.filetype.add({ extension = { ron = "ron" } })
		vim.filetype.add({
			extension = {
				prisma = "prisma",
			},
		})

		local ensure_installed = {
			"lua",
			"javascript",
			"typescript",
			"html",
			"css",
			"markdown",
			"c",
			"cpp",
			"c_sharp",
			"python",
			"rust",
			"json",
			"dockerfile",
			"graphql",
			"svelte",
			"java",
			"gdscript",
			"godot_resource",
			"gdshader",
			"hlsl",
			"glsl",
			"toml",
			"yaml",
			"ocaml",
			"prisma",
			"go",
			"gomod",
			"gosum",
			"gotmpl",
			"ron",
			"haskell",
			"vim",
			"vimdoc",
			"odin",
			"slang",
		}

		require("nvim-treesitter").setup({
			ensure_installed = ensure_installed,
		})

		-- Start Treesitter highlighting/indentation for supported filetypes
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		-- Auto-install missing parsers
		local already_installed = require("nvim-treesitter.config").get_installed()

		local parsers_to_install = vim.iter(ensure_installed)
			:filter(function(parser)
				return not vim.tbl_contains(already_installed, parser)
			end)
			:totable()

		if #parsers_to_install > 0 then
			require("nvim-treesitter").install(parsers_to_install)
		end

		-- Command to print installed parsers
		vim.api.nvim_create_user_command("TSInstalled", function()
			local installed = require("nvim-treesitter.config").get_installed()

			for _, parser in ipairs(installed) do
				print(parser)
			end
		end, {})
	end,
}
