-- Allow clipboard access in WSL
if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}

	vim.opt.clipboard = "unnamedplus"
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
