return {
	"rcarriga/nvim-notify",
	name = "notify",
	lazy = false,
	priority = 999,
	config = function()
		local notify = require("notify")
		notify.setup()
		vim.notify = notify
	end,
}
