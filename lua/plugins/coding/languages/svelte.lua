local group = vim.api.nvim_create_augroup("SvelteSetup", {})
vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "svelte" },
  group = group,
  callback = function()
    local lsp = require("plugins.coding.lsp")
    if lsp.lspconfig == nil then
      lsp.config()
    end

    local lsp_on_attach = function(client, bufnr)
      lsp.on_attach(client, bufnr)
      lsp.format(client, bufnr)
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
    end

    lsp.lspconfig["svelte"].setup({
      capabilities = lsp.capabilities,
      on_attach = lsp_on_attach,
    })

    vim.api.nvim_clear_autocmds({ group = group })
    vim.api.nvim_exec_autocmds("FileType", {
      pattern = { "svelte" },
      group = "lspconfig",
    })
  end,
})

return {}
