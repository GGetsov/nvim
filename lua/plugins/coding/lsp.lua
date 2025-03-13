local M = {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "j-hui/fidget.nvim",
    },
    init = function()
      -- restart lsp server
      Keymap.set("n", "<leader>rs", ":LspRestart<CR>")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    enabled = not ON_NIXOS,
    lazy = true,
    dependencies = {
      "williamboman/mason.nvim",
      enabled = not ON_NIXOS,
    },
    opts = {
      --LS on Nixos should be installed by nix (mainly inside a nix-shell)
      automatic_installation = not ON_NIXOS,
    },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    opts = {
      lightbulb = {
        enable = true,
        enable_in_insert = false,
        sign = true,
        sign_priority = 1,
        virtual_text = true,
      },
      ui = {
        code_action = "🩹",
      },
      diagnostic = {
        on_insert = false,
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter", --Please make sure you install markdown and markdown_inline parser
      "neovim/nvim-lspconfig",
    },
  },
}

M.config = function()
  M.lspconfig = require("lspconfig")
  local cmp_nvim_lsp = require("cmp_nvim_lsp") -- bridge between cmp and lsp

  -- enable keybinds only for when lsp server available
  M.on_attach = function(client, bufnr)
    -- keybind options
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- set keybinds
    Keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)                      -- show definition, references
    Keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)           -- go to declaration
    Keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)                 -- see definition and make edits in window
    Keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)        -- go to implementation
    Keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)             -- see available code actions
    Keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)                  -- smart rename
    Keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)   -- show  diagnostics for line
    Keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
    Keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)            -- jump to previous diagnostic in buffer
    Keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)            -- jump to next diagnostic in buffer
    Keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)                        -- show documentation for what is under cursor
    Keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)                  -- see outline on right hand side

    -- require("lsp-inlayhints").on_attach(client, bufnr)
  end

  -- used to enable autocompletion (assign to every lsp server config)
  M.capabilities = cmp_nvim_lsp.default_capabilities()

  --augroup for on save formatting autocmd
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  -- additional command to on_attach for languages without formatter to format on save
  M.format = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
          })
        end,
      })
    end
  end

  -- Change the Diagnostic symbols in the sign column (gutter)
  -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  local signs = { Error = "🚨", Warn = "💊", Hint = "🧠", Info = "🔬" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- diagnostics don't show on same line and signs are sorted by severity Error -> Hint
  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
  })
end

return M
