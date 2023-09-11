return {
	"jose-elias-alvarez/typescript.nvim",
	ft = { "ts" },
	config = function()
		local lsp = require("plugins.coding.lsp")
		if lsp.lspconfig == nil then
			lsp.config()
		end

		require("typescript").setup({
			server = { -- pass options to lspconfig's setup method
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
			},
		})
	end,
}
