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

-- To remove a harpoon record, simply press `dd` in the harpoon list menu

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
