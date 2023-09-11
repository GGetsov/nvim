P = function(v)
	print(vim.inspect(v))
	return v
end

IS_WINDOWS = vim.loop.os_uname().sysname == "Windows_NT"

IS_NIXOS = vim.fn.filereadable("/etc/NIXOS") == 1

if IS_NIXOS then NIX_PKGS = require("nixos-dir.managed")
else NIX_PKGS = {} end

Keymap = vim.keymap

Filetypes = { "lua", "rust" }
