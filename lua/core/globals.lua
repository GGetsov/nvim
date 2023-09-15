P = function(v)
	print(vim.inspect(v))
	return v
end

ON_WINDOWS = vim.loop.os_uname().sysname == "Windows_NT"

ON_NIXOS = vim.fn.filereadable("/etc/NIXOS") == 1

if ON_NIXOS then NIX_PKGS = require("nix-plugins")
else NIX_PKGS = {} end

Keymap = vim.keymap

Filetypes = { "lua", "rust" }
