local group = vim.api.nvim_create_augroup("TermOpen", {})
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = group,
  callback = function()
    vim.api.nvim_command("setlocal nonumber norelativenumber")
    vim.api.nvim_command("startinsert")
  end
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", }, {
  pattern = 'term://*',
  group = group,
  callback = function()
    vim.api.nvim_command("startinsert")
  end
})
