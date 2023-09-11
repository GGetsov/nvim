return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integrations = {
				notify = true,
				mini = true,
			},
		})
		vim.cmd.colorscheme("catppuccin-macchiato")
	end,
}
