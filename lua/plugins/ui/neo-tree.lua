return {
	"nvim-neo-tree/neo-tree.nvim",
	lazy = true,
	init = function()
		Keymap.set("n", "<leader>e", ":Neotree toggle<CR>") -- toggle file explorer

		-- open neotree if opened inside directory
		local buf = vim.api.nvim_get_current_buf()
		local bufname = vim.api.nvim_buf_get_name(buf)
		if vim.fn.isdirectory(bufname) == 1 then
			vim.cmd("Neotree")
		end
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	config = function()
		-- If you want icons for diagnostic errors, you'll need to define them somewhere:
		-- vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
		-- vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
		-- vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
		-- vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

		require("neo-tree").setup({
			event_handlers = {
				{
					event = "file_opened",
					handler = function(file_path)
						require("neo-tree").close_all()
					end,
				},
			},
		})
	end,
}
