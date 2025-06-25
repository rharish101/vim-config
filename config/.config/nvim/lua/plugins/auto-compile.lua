-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

return {
	"tpope/vim-dispatch",
	config = function()
		vim.g.dispatch_handlers = { "headless" } -- Don't use tmux.
		local compileGroup = vim.api.nvim_create_augroup("autoCompile", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			pattern = "*.tex",
			group = compileGroup,
			command = "Make!",
		})
	end,
}
