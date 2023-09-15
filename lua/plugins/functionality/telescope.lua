local build_cmd = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release ; cmake --build build --config Release ; cmake --install build --prefix build"

-- remove build_cmd if on Nixos
build_cmd = not ON_NIXOS and build_cmd or nil

return {
	"nvim-telescope/telescope.nvim", -- fuzzy finder
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
            dir = NIX_PKGS["telescope-fzf-native.nvim"],
			build = build_cmd,
		},
		"nvim-telescope/telescope-file-browser.nvim",
	},
	init = function()
		-- telescope
		Keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>") -- find files within current working directory, respects .gitignore
		Keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>") -- find string in current working directory as you type
		Keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>") -- find string under cursor in current working directory
		Keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>") -- list open buffers in current neovim instance
		Keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>") -- list available help tags
		Keymap.set(
			"n",
			"<leader>fd",
			function() -- list errors and warnings (fixes bug where it doesn't give full message)
				require("telescope.builtin").diagnostics({ line_width = false })
			end
		)

		-- telescope git commands
		Keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
		Keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<CR>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
		Keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
		Keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>") -- list current changes per file with diff preview ["gs" for git status]
	end,
	cmd = "Telescope",
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.load_extension("file_browser")
        telescope.load_extension("fzf")

		-- configure telescope
		telescope.setup({
			extetentions = {
				file_browser = {},
			},
			-- configure custom mappings
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
					},
				},
				wrap_results = true,
			},
		})
	end,
}
