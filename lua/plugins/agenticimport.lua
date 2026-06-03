return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	---@module 'avante'
	opts = {
		-- add any opts here
		-- this file can contain specific instructions for your project
		instructions_file = "avante.md",
		-- for example
		-- provider = "copilot"
		provider = "copilot",
		behaviour = {
			auto_suggestions = false,
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
			minimize_diff = true,
			enable_token_counting = true,
			auto_add_current_file = true,
			auto_approve_tool_permissions = false,
			confirmation_ui_style = "inline_buttons",
			acp_follow_agent_locations = true,
		},
		windows = {
			position = "left", -- Chat window appears on the left
			wrap = true,
			width = 25,
		},
		-- acp_providers = {
		-- 	codex = {
		-- 		command = "codex-acp",
		-- 		args = {},
		-- 		env = {
		-- 			NODE_NO_WARNINGS = "1",
		-- 			HOME = os.getenv("HOME"),
		-- 			PATH = os.getenv("PATH"),
		-- 			OPENAI_API_KEY = os.getenv("OPENAI_API_KEY"),
		-- 		},
		-- 	},
		-- },
		providers = {
			copilot = {
				model = "claude-sonnet-4.6",
				timeout = 30000, -- Timeout in milliseconds
			},

			-- claude = {
			-- 	endpoint = "https://api.anthropic.com",
			-- 	model = "claude-sonnet-4-20250514",
			-- 	timeout = 30000, -- Timeout in milliseconds
			-- 	extra_request_body = {
			-- 		temperature = 0.75,
			-- 		max_tokens = 20480,
			-- 	},
			-- },
			-- moonshot = {
			-- 	endpoint = "https://api.moonshot.ai/v1",
			-- 	model = "kimi-k2-0711-preview",
			-- 	timeout = 30000, -- Timeout in milliseconds
			-- 	extra_request_body = {
			-- 		temperature = 0.75,
			-- 		max_tokens = 32768,
			-- 	},
			-- },
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		--"nvim-mini/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		--"ibhagwan/fzf-lua", -- for file_selector provider fzf
		--"stevearc/dressing.nvim", -- for input provider dressing
		--"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}

-- Key binds applied by Avante
-- `A`             Apply all
-- `a`             Apply cursor
-- `r`             Retry user request
-- `e`             Edit user request
-- `<Tab>`         Switch windows
-- `<S-Tab>`       Reverse switch windows
-- `d`             Remove file
-- `@`             Add file
-- `q`             Close sidebar
-- `<leader>aa`    Show sidebar
-- `<leader>at`    Toggle sidebar visibility
-- `<leader>ar`    Refresh sidebar
-- `<leader>af`    Switch sidebar focus
-- `]p`            Next prompt
-- `[p`            Previous prompt
--
-- Suggestion~
--
--                                              *avante.nvim-suggestion-keymaps*
-- `<leader>a?`    Select model
-- `<leader>an`    New ask
-- `<leader>ae`    Edit selected blocks
-- `<leader>aS`    Stop current AI request
-- `<leader>ah`    Select between chat histories
-- `<M-l>`         Accept suggestion
-- `<M-]>`         Next suggestion
-- `<M-[>`         Previous suggestion
-- `<C-]>`         Dismiss suggestion
-- `<leader>ad`    Toggle debug mode
-- `<leader>as`    Toggle suggestion display
-- `<leader>aR`    Toggle repository map
--
-- Files~
--
--                                                   *avante.nvim-file-keymaps*
-- `<leader>ac`    Add current buffer to selected files
-- `<leader>aB`    Add all buffer files to selected files
--
-- Diff~
--
--                                                   *avante.nvim-diff-keymaps*
-- `co`            Choose ours
-- `ct`            Choose theirs
-- `ca`            Choose all theirs
-- `cb`            Choose both
-- `cc`            Choose cursor
-- `]x`            Move to next conflict
-- `[x`            Move to previous conflict
--
-- Confirm~
--
--                                                *avante.nvim-confirm-keymaps*
-- `<C-w>f`        Focus confirm window
-- `c`             Confirm code
-- `r`             Confirm response
-- `i`             Confirm input
