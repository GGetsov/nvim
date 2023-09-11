return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		keys = "<F5>",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"williamboman/mason.nvim",
		},
		init = function()
			-- debugger
			local opts = { noremap = true, silent = true }
			Keymap.set("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", opts)
			Keymap.set("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", opts)
			Keymap.set("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", opts)
			Keymap.set("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>", opts)
			Keymap.set("n", "<Leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
			Keymap.set(
				"n",
				"<Leader>B",
				"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				opts
			)
			Keymap.set(
				"n",
				"<Leader>lp",
				"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
				opts
			)
			Keymap.set("n", "<Leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", opts)
			Keymap.set("n", "<Leader>dl", "<cmd>lua require'dap'.run_last()<CR>", opts)
		end,
		config = function()
			local mason_dap = require("mason-nvim-dap")
			mason_dap.setup({
				ensure_installed = { "python" },
			})

			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
