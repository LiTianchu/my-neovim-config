return {
	"yetone/avante.nvim",
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false,
	---@module 'avante'
	opts = {
		instructions_file = "avante.md",
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
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
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
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
-- Key binds from Avante official documentation: https://github.com/yetone/avante.nvim
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
