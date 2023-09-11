return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			-- enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = { enable = true },
			-- ensure these language parsers are installed
			ensure_installed = {
				"json",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"python",
				"rust",
				"toml",
				"c",
				"cpp",
				"arduino",
			},
			-- auto install above language parsers
			auto_install = true,
		})
	end,
}
