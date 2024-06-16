local group = vim.api.nvim_create_augroup("NixSetup", {})
vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "nix" },
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

    lsp.lspconfig["nil_ls"].setup({
      capabilities = lsp.capabilities,
      on_attach = lsp_on_attach,
    })

    vim.api.nvim_clear_autocmds({ group = group })
    vim.api.nvim_exec_autocmds("FileType", {
      pattern = { "nix" },
      group = "lspconfig",
    })
  end,
})

return {}
