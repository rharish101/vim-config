-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

return {
	-- Completion engine
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},

				mapping = {
					-- Select item in completion menu.
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({ select = true })
							end
						else
							fallback()
						end
					end),

					-- Nav next in completion menu.
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					-- Nav prev in completion menu.
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
			})
		end,
	},

	-- Language server integration
	{
		"hrsh7th/cmp-nvim-lsp",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", { capabilities = capabilities })
		end,
	},

	-- Snippet engine integration
	{ "saadparwaiz1/cmp_luasnip" },
}
