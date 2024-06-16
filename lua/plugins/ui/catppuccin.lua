return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavor = "macchiato",
      transparent_background = true,
      integrations = {
        notify = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
