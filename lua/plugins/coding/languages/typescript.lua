local group = vim.api.nvim_create_augroup("JSSetup", {})
vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  group = group,
  callback = function()
    local lsp = require("plugins.coding.lsp")
    if lsp.lspconfig == nil then
      lsp.config()
    end

    local lsp_on_attach = function(client, bufnr)
      lsp.on_attach(client, bufnr)
    end

    lsp.lspconfig["ts_ls"].setup({
      capabilities = lsp.capabilities,
      on_attach = lsp_on_attach,
    })

    vim.api.nvim_clear_autocmds({ group = group })
    vim.api.nvim_exec_autocmds("FileType", {
      pattern = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
      group = "lspconfig",
    })
  end,
})

return {}
