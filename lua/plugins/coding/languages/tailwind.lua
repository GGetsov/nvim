local group = vim.api.nvim_create_augroup("TailWindSetup", {})
vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "css", "svelte", "html", "js", "ts" },
  group = group,
  callback = function()
    local lsp = require("plugins.coding.lsp")
    if lsp.lspconfig == nil then
      lsp.config()
    end

    local lsp_on_attach = function(client, bufnr)
      lsp.on_attach(client, bufnr)
    end

    lsp.lspconfig["tailwindcss"].setup({
      capabilities = lsp.capabilities,
      on_attach = lsp_on_attach,
    })

    vim.api.nvim_clear_autocmds({ group = group })
    vim.api.nvim_exec_autocmds("FileType", {
      pattern = { "css", "svelte", "html", "js", "ts" },
      group = "lspconfig",
    })
  end,
})

return {}
