-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

function listContains(list, item)
	for i = 1, #list do
		if list[i] == item then
			return true
		end
	end
	return false
end

return {
	"kevinhwang91/nvim-ufo",
	commit = "5b75cf5fdb74054fc8badb2e7ca9911dc0470d94",
	dependencies = "kevinhwang91/promise-async",
	opts = {
		provider_selector = function(bufnr, filetype, buftype)
			-- Setup treesitter with indent as fallback.
			if listContains(_G.ufo_ignore_bufnrs, bufnr) or listContains(_G.ufo_ignore_filetypes, filetype) then
				return { "indent" }
			else
				return { "treesitter", "indent" }
			end
		end,
	},
	config = function(_, opts)
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99

		-- Global variables where project-specific configs can add buffers/filetypes where treesitter shouldn't be used.
		_G.ufo_ignore_bufnrs = {}
		_G.ufo_ignore_filetypes = {}

		local ufo = require("ufo")
		ufo.setup(opts)

		vim.keymap.set("n", "<space>", "za")
		vim.keymap.set("n", "zR", ufo.openAllFolds)
		vim.keymap.set("n", "zM", ufo.closeAllFolds)
	end,
}
