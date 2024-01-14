return {
  "folke/neodev.nvim",
  dependencies = "neovim/nvim-lspconfig",
  ft = "lua",
  config = function()
    local lsp = require("plugins.coding.lsp")
    if lsp.lspconfig == nil then
      lsp.config()
    end

    require("neodev").setup({
      library = {
        plugins = {
          "nvim-dap-ui",
        },
        types = true,
      },
    })

    --configure lsp
    lsp.lspconfig["lua_ls"].setup({
      capabilities = lsp.capabilities,
      on_attach = function(client, bufnr)
        lsp.on_attach(client, bufnr)
        lsp.format(client, bufnr)
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
      end,
      settings = { -- custom settings for lua
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          completion = {
            callSnippet = "Replace",
          },
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
  end,
}
