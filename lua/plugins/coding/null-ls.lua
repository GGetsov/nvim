--Nixos handles it's own LS/Formatters/Linters
local needed = ON_NIXOS and {} or {
  "stylua",
}

return {
  {
    "nvimtools/none-ls.nvim",
    -- enabled = false,
    dependencies = {
      "williamboman/mason.nvim",
      enabled = not ON_NIXOS,
    },
    lazy = true,
    config = function()
      -- for conciseness
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting   -- to setup formatters
      local diagnostics = null_ls.builtins.diagnostics -- to setup linters

      -- to setup format on save
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      null_ls.setup({
        -- setup source (if not automattically setup)
        -- sources = {
        -- 	formatting.stylua,
        -- },

        -- configure format on save
        on_attach = function(current_client, bufnr)
          if current_client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  filter = function(client)
                    --  only use null-ls for formatting instead of lsp server
                    return client.name == "null-ls"
                  end,
                  bufnr = bufnr,
                })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "jayp0521/mason-null-ls.nvim", -- should be loaded last
    enabled = not ON_NIXOS,
    dependencies = "nvimtools/none-ls.nvim",
    config = function()
      local mason_null_ls = require("mason-null-ls")
      mason_null_ls.setup({
        ensure_installed = needed,
        automatic_installation = false,
        automatic_setup = true,
      })
      -- mason_null_ls.setup_handlers({})
    end,
  },
}
