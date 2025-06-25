-- SPDX-FileCopyrightText: 2025 Harish Rajagopal <harish.rajagopals@gmail.com>
--
-- SPDX-License-Identifier: MIT

return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.enable("nixd")
		vim.lsp.enable("pyright")
		vim.lsp.enable("ruff")
		vim.lsp.enable("rust_analyzer")
		vim.lsp.enable("texlab")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client == nil then
					return
				end
				if client.name == "ruff" then
					-- Disable hover in favor of Pyright
					client.server_capabilities.hoverProvider = false
				end
			end,
			desc = "LSP: Disable hover capability from Ruff",
		})
		vim.lsp.config["pyright"] = {
			settings = {
				-- Using Ruff's import organizer
				pyright = { disableOrganizeImports = true },
				-- Ignore all files for analysis to exclusively use Ruff for linting
				python = { analysis = { ignore = { "*" } } },
			},
		}

		vim.lsp.config["rust_analyzer"] = {
			settings = {
				["rust-analyzer"] = {
					cargo = { features = "all" },
					check = { command = "clippy" },
				},
			},
		}
	end,
}
