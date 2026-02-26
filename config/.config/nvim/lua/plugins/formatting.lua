-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

return {
	-- Language-specific automatic formatting
	{
		"stevearc/conform.nvim",
		opts = {
			default_format_opts = {
				async = true,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				css = { "prettier" },
				html = { "prettier" },
				javascript = { "prettier" },
				lua = { "stylua" },
				python = {
					-- To fix auto-fixable lint errors.
					"ruff_fix",
					-- To run the Ruff formatter.
					"ruff_format",
					-- To organize the imports.
					"ruff_organize_imports",
				},
				scss = { "prettier" },
			},
		},
		config = function(_, opts)
			local conform = require("conform")
			conform.setup(opts)
			vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
			vim.keymap.set("n", "<Leader>f", conform.format)
		end,
	},

	-- Remove trailing whitespace.
	{ "ntpeters/vim-better-whitespace" },

	-- Change casing (e.g. capitalization)
	{ "johmsalas/text-case.nvim", opts = {} },

	-- Arrange text in a tabular form.
	{ "godlygeek/tabular" },

	-- Automatic enclosing brackets, quotes, etc.
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup()

			local Rule = require("nvim-autopairs.rule")
			npairs.add_rules({
				Rule("$", "$", { "tex", "latex" }),
			})
		end,
	},

	-- Shortcuts to edit enclosing brackets, quotes, etc.
	{ "tpope/vim-surround" },
}
