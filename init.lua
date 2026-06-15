-- Set mapleader before loading any plugins or settings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.titlestring = "%{getcwd()}"
vim.o.title = true

vim.o.splitbelow = true

require("misc.options") -- general settings
require("misc.keybinds") -- keybindings

-- Make sure .prisma files are detected correctly
vim.filetype.add({
	extension = {
		prisma = "prisma",
	},
})

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
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			opts = {
				transparent = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
			},
		},
		{
			"nvim-telescope/telescope.nvim",
			branch = "master",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		{
			"nvim-treesitter/nvim-treesitter",
			branch = "main",
			lazy = false,
			build = ":TSUpdate",
			config = function()
				-- Register the custom RON parser BEFORE setup
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

				-- Filetype detection for .ron files
				vim.filetype.add({ extension = { ron = "ron" } })

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
		},

		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
				"nvim-tree/nvim-web-devicons",
			},
			lazy = false,
		},
		{ "MunifTanjim/nui.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
			---@module 'render-markdown'
			---@type render.md.UserConfig
			opts = {},
		},
		{ "windwp/nvim-ts-autotag" },
		{
			"HiPhish/rainbow-delimiters.nvim",
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
			},
		},
		require("plugins.debuggerimport"),
		require("plugins.copilotimport"),
		require("plugins.lspimport"),
		require("plugins.agenticimport"),
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})

require("themes.color")
local telescope_builtin = require("telescope.builtin")

require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules/",
			".git",
			"dist/",
			"build/",
			"%.meta",
			"temp/",

			-- godot specific patterns
			"%.uid",
			"%.tscn",
			"%.tres",
			"%.import",
			"%.res",

			-- unity specific patterns
			"%.unity",
			"%.asset",
			"%.prefab",
			"%.mat",
			"%.anim",
			"%.controller",
			"%.lighting",

			-- image formats
			"%.png",
			"%.jpg",
			"%.jpeg",
			"%.tga",
			"%.webp",
			"%.webm",
			"%.bmp",
			"%.gif",

			-- archive formats
			"%.zip",
			"%.tar",
			"%.gz",
			"%.7z",

			-- executable formats
			"%.exe",

			-- windows dynamic library format
			"%.dll",

			-- audio/video formats
			"%.mp3",
			"%.wav",
			"%.ogg",
			"%.mp4",
			"%.mkv",
			"%.avi",

			-- 3D model formats
			"%.fbx",
			"%.gltf",
			"%.glb",

			-- Media source files
			"%.psd",
			"%.aseprite",
			"%.blend",

			-- font files
			"%.ttf",
			"%.otf",
			"%.woff",
			"%.woff2",
		},
	},
	pickers = {
		find_files = {
			hidden = false,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
	preview = {
		treesitter = true,
	},
})

-- load telescope ui select extension
require("telescope").load_extension("ui-select")

vim.keymap.set("n", "<C-p>", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})
vim.keymap.set("n", "<leader>fd", telescope_builtin.diagnostics, {})
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {})

require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = false,
			hide_dotfiles = true,
			hide_gitignored = true,
			hide_ignored = true,
			ignore_files = {
				".neotreeignore",
				".ignore",
			},
			hide_by_name = {
				"node_modules",
				".git",
			},
			hide_by_pattern = {
				"*.meta",
				"*/src/*/temp/*",

				-- godot specific patterns
				"*.uid",
				"*.tscn",
				"*.tres",
				"*.import",

				-- unity specific patterns
				"*.unity",
				"*.asset",
				"*.prefab",
			},
			never_show = {
				".DS_Store",
				"thumbs.db",
			},
			always_show = {
				".gitignore",
				".gitattributes",
				".prettier*",
				".config",
				".vscode",
				".zed",
				".vs",
				".idea",
			},
			always_show_by_pattern = {
				".env*",
				"*.tscn",
				"*.tres",
			},
		},
	},
	window = {
		position = "right",
		width = 32,
	},
})

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>ma", function()
	harpoon:list():add()
end)

vim.keymap.set("n", "<leader>ml", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function()
	harpoon:list():prev()
end)

vim.keymap.set("n", "<C-S-N>", function()
	harpoon:list():next()
end)

require("lualine").setup({
	options = {
		theme = "everforest",
	},
})

require("plugins.copilotconfig")
require("plugins.lspconfig")

require("nvim-ts-autotag").setup({
	opts = {
		enable_close = true,
		enable_rename = true,
		enable_close_on_slash = false,
	},
	per_filetype = {
		["html"] = {
			enable_close = false,
		},
	},
})

-- Allow clipboard access in WSL
if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end

-- listen to godot host when open
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local godotprojectfile = vim.fn.getcwd() .. "/project.godot"
		if vim.fn.filereadable(godotprojectfile) == 1 then
			vim.fn.serverstart("/tmp/godothost")
		end
	end,
})

-- -- Auto open avante on startup
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		require("avante.api").ask()
-- 	end,
-- })
