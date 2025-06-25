-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

return {
	"ishan9299/nvim-solarized-lua",
	config = function()
		vim.g.solarized_statusline = "flat"
		vim.cmd.colorscheme("solarized")
	end,
}
