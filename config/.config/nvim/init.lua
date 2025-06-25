-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

vim.g.mapleader = ","
vim.opt.laststatus = 0
vim.opt.wrap = false
vim.opt.nrformats:append({ "alpha" })
vim.opt.showmatch = true
vim.opt.undofile = true
vim.opt.formatoptions:append({ r = true, o = true })
vim.opt.viewoptions:remove({ "curdir" })
vim.opt.exrc = true
vim.opt.fillchars = { eob = " " }
vim.opt.termguicolors = true

-- Indentation
vim.opt.shiftround = true
vim.api.nvim_create_user_command("SetIndent", function(opts)
	local indent = tonumber(opts.fargs[1])
	vim.opt_local.expandtab = true
	vim.opt_local.softtabstop = indent
	vim.opt_local.shiftwidth = indent
end, { nargs = 1 })

-- Split windows to the bottom/right of the current one.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Show absolute line numbers for the current line, and relative numbers for others.
vim.opt.number = true
vim.opt.relativenumber = true

-- Ignore casing, unless a capital letter is used.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight the current line number.
vim.opt.cursorline = true
vim.opt.cursorlineopt = { "number" }

-- Save the file 'view' after closing and load it when opening.
local viewGroup = vim.api.nvim_create_augroup("autoSaveView", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = "?*",
	group = viewGroup,
	command = "mkview",
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "?*",
	group = viewGroup,
	command = "silent! loadview",
})

-- File type specific settings
local fileTypeGroup = vim.api.nvim_create_augroup("fileTypeOpts", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "php" },
	group = fileTypeGroup,
	command = "SetIndent 4",
	desc = "Convert tabs to 4 spaces",
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "css", "html", "javascript", "json", "nix", "r", "typescript", "vim" },
	group = fileTypeGroup,
	command = "SetIndent 2",
	desc = "Convert tabs to 2 spaces",
})

-- LaTeX specific settings
vim.g.tex_flavor = "latex" -- Use the `tex` filetype for all ".tex" files.
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "tex",
	group = fileTypeGroup,
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_gb"
	end,
})

-- Buffer movements
vim.keymap.set("n", "<C-N>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<C-P>", "<cmd>bprev<cr>")
-- Delete buffer while moving to the previous buffer.
vim.api.nvim_create_user_command("BufDelete", "bp | bd #", {})

-- Clipboard shortcuts
vim.keymap.set({ "n", "v", "s", "o" }, "<leader>y", '"+y', { remap = true })
vim.keymap.set({ "n", "v", "s", "o" }, "<leader>Y", '"+yy', { remap = true })
vim.keymap.set({ "n", "v", "s", "o" }, "<leader>p", 'o<space><ESC>v"+p', { remap = true })
vim.keymap.set({ "n", "v", "s", "o" }, "<leader><S-p>", '<S-o><space><ESC>v"+p', { remap = true })
vim.keymap.set({ "n", "v", "s", "o" }, "<leader>d", '"+d', { remap = true })

-- Misc. keymaps
vim.keymap.set("n", "Y", "yy", { remap = true })

-- Plugins
require("config.lazy")
