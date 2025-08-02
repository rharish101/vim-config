-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

return {
	-- Buffers as tabs
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {},
	},

	-- Undo history as a tree
	{ "mbbill/undotree" },

	-- Scrolling animations
	{ "karb94/neoscroll.nvim", opts = {} },

	-- Indentation lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = { indent = { char = "▏" } },
	},

	-- File browser
	{
		"mcchrish/nnn.vim",
		enabled = vim.fn.executable("nnn"),
		opts = {
			command = "nnn -A",
			replace_netrw = true,
		},
		config = function(_, opts)
			require("nnn").setup(opts)
			vim.keymap.set("n", "<Leader>N", "<cmd>NnnPicker %:p:h<cr>")
		end,
	},
}
