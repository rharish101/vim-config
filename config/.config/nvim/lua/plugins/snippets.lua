-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

return {
	"L3MON4D3/LuaSnip",
	-- Install jsregexp (optional!).
	build = "make install_jsregexp",
	config = function()
		local luasnip = require("luasnip")
		luasnip.add_snippets("tex", {
			-- Equivalent to '${1:cond} ? ${2:then} : ${3:else}'
			luasnip.snippet("env", {
				luasnip.insert_node(1, "cond"),
				luasnip.text_node(" ? "),
				luasnip.insert_node(2, "then"),
				luasnip.text_node(" : "),
				luasnip.insert_node(3, "else"),
			}),
		})
	end,
}
