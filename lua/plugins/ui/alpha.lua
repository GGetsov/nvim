return {
	"goolord/alpha-nvim",
	name = "alpha",
	cond = function()
		local buf = vim.api.nvim_get_current_buf()
		local bufname = vim.api.nvim_buf_get_name(buf)
		if bufname == "" then
			return true
		end
		return false
	end,
	config = function()
		require("alpha").setup(require("alpha.themes.dashboard").config)
	end,
}
