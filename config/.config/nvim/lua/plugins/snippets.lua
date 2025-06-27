-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

return {
	"L3MON4D3/LuaSnip",
	-- Install jsregexp (optional!).
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")

		-- Aliases
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local rep = require("luasnip.extras").rep
		local fmta = require("luasnip.extras.fmt").fmta

		ls.add_snippets("tex", {
			-- Environments
			s(
				"env",
				fmta(
					[[
						\begin{<>}
							<>
						\end{<>}
					]],
					{ i(1, "env"), i(2, "Content"), rep(1) }
				)
			),
			-- Inline environments
			s("inline_env", fmta("\\begin{<>}<>\\end{<>}", { i(1, "env"), i(2, "Content"), rep(1) })),
		})
	end,
}
