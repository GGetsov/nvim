return {
	"lukas-reineke/indent-blankline.nvim",
	lazy = true,
	event = "BufRead",
	config = function()
		CustomHl = vim.api.nvim_get_hl_by_name("Include", true)
		vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = CustomHl.foreground })
		vim.opt.list = true

		require("indent_blankline").setup({
			space_char_blankline = " ",
			show_current_context = true,
		})
	end,
}
