-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

return {
	"rharish101/okselenized.nvim",
	dependencies = { "rktjmp/lush.nvim", branch = "main" },
	config = function()
		vim.g.selenized_variant = "bw"
		vim.cmd.colorscheme("selenized")
	end,
}
