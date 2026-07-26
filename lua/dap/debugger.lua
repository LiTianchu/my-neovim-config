return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- DAP UI (floating windows for vars, stack, breakpoints)
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			-- Virtual text showing variable values inline
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Currently only supports GDScript debugging via Godot Engine's DAP server
			-- Add more if need other debuggers

			--  Godot DAP adapter (connects to port 6006)
			--  Godot must be running with DAP enabled
			dap.adapters.godot = {
				type = "server",
				host = "127.0.0.1",
				port = 6006,
			}

			dap.configurations.gdscript = {
				{
					type = "godot",
					request = "launch",
					name = "Launch Godot Scene",
					project = "${workspaceFolder}",
					-- launch_game_instance = false, -- Godot is already open
					-- launch_scene = false,
				},
			}

			-- DAP UI auto-open on session start
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- UI layout
			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.33 },
							{ id = "breakpoints", size = 0.17 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						position = "left",
						size = 40,
					},
					{
						elements = { { id = "repl", size = 1 } },
						position = "bottom",
						size = 10,
					},
				},
			})

			require("nvim-dap-virtual-text").setup({ commented = true })

			-- DAP Keymaps
			local map = vim.keymap.set
			map("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
			map("n", "<F8>", dap.step_over, { desc = "DAP: Step Over" })
			map("n", "<F9>", dap.step_into, { desc = "DAP: Step Into" })
			map("n", "<F10>", dap.step_out, { desc = "DAP: Step Out" })
			map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
			map("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Condition: "))
			end, { desc = "DAP: Conditional Breakpoint" })
			map("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
			map("n", "<leader>dr", dap.repl.open, { desc = "DAP: REPL" }) -- Stop / Pause / Detach
			map("n", "<leader>ds", dap.terminate, { desc = "DAP: Stop" })
			map("n", "<leader>dp", dap.pause, { desc = "DAP: Pause" })
			map("n", "<leader>dx", dap.disconnect, { desc = "DAP: Detach" })
		end,
	},
}
