local group = vim.api.nvim_create_augroup("RustSetup", {})
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "rust",
  group = group,
  callback = function()
    local lsp = require("plugins.coding.lsp")
    if lsp.lspconfig == nil then
      lsp.config()
    end

    local lsp_on_attach = function(client, bufnr)
      lsp.on_attach(client, bufnr)
      lsp.format(client, bufnr)
    end

    lsp.lspconfig["rust_analyzer"].setup({
      capabilities = lsp.capabilities,
      on_attach = lsp_on_attach,
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
            disabled = { "unresolved-proc-macro" },
            enableExperimental = true,
          },
          checkOnSave = {
            allFeatures = true,
            command = "clippy",
          },
        },
      },
    })
    local dap = require("dap")
    local extension_path = require("mason-registry").get_package("codelldb"):get_install_path()
    local codelldb_path = extension_path .. "/extension/adapter/codelldb.exe"
    -- local liblldb_path = extension_path .. "/extension/lldb/bin/liblldb.dll"

    local adapter_settings = {
      type = "server",
      port = "${port}",
      executable = {
        command = codelldb_path,
        args = {
          -- "--liblldb",
          -- liblldb_path,
          "--port",
          "${port}",
        },
        -- On windows you may have to uncomment this:
        -- detached = false,
      },
    }

    dap.adapters.codelldb = adapter_settings

    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          vim.fn.system("cargo build")
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    vim.api.nvim_clear_autocmds({ group = group })
    vim.api.nvim_exec_autocmds("FileType", {
      pattern = "rust",
      group = "lspconfig",
    })
  end,
})

return {}
