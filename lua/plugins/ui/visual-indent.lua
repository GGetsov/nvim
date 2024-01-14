return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = true,
  event = "BufRead",
  config = function()
    require("ibl").setup({
      scope = {
        highlight = "Statement",
        show_start = false,
        show_end = false,
      }
    })
  end,
}
