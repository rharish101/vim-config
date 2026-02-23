-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

return {
	"MeanderingProgrammer/treesitter-modules.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
	},
	opts = {
		ensure_installed = {
			"bash",
			"css",
			"fish",
			"html",
			"javascript",
			"latex",
			"lua",
			"nix",
			"python",
			"rust",
			"scss",
			"typescript",
		},
		fold = { enable = true },
		highlight = { enable = true },
		indent = { enable = true },
	},
}
