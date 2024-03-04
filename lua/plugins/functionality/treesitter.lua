-- No need to auto install or update on Nixos bc all parsers are handled by nix
local build_cmd = not ON_NIXOS and ":TSUpdate" or nil
local parsers =
-- ON_NIXOS and {} or
{
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
  "svelte",
  "vimdoc"
}

return {
  "nvim-treesitter/nvim-treesitter",
  -- maybe i will fix this later idk
  -- dir = NIX_PKGS["nvim-treesitter"],
  build = build_cmd,
  -- event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- enable syntax highlighting
      highlight = {
        enable = true,
        -- fucking bash doesn't work and i just want to remove the fucking error
        -- disable = { "bash" },
      },

      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = { enable = true },
      -- ensure these language parsers are installed
      ensure_installed = parsers,
      -- auto install above language parsers
      -- auto_install = ON_NIXOS,
      auto_install = true,
    })
  end,
}
