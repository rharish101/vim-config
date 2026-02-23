-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

return {
	"lifepillar/vim-solarized8",
	branch = "neovim",
	config = function()
		vim.g.solarized_statusline = "flat"
		vim.cmd.colorscheme("solarized8")
	end,
}
