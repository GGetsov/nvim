local group = vim.api.nvim_create_augroup("PythonSetup", {})
vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "pyhton" },
    group = group,
    callback = function()
        -- vim.notify("hey")
        local lsp = require("plugins.coding.lsp")
        if lsp.lspconfig == nil then
            lsp.config()
        end

        local lsp_on_attach = function(client, bufnr)
            lsp.on_attach(client, bufnr)
            lsp.format(client, bufnr)
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
        end

        lsp.lspconfig["pyright"].setup({
            capabilities = lsp.capabilities,
            on_attach = lsp_on_attach,
        })

        vim.api.nvim_clear_autocmds({ group = group })
        vim.api.nvim_exec_autocmds("FileType", {
            pattern = { "pyhton" },
            group = "lspconfig",
        })
    end,
})

return {}
