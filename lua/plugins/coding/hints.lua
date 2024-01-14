return {
  "lvimuser/lsp-inlayhints.nvim",
  branch = "anticonceal",
  lazy = true,
  opts = {
    inlay_hints = {
      label_formatter = function(labels, kind, opts, client_name)
        if kind == 2 and not opts.parameter_hints.show then
          return ""
        elseif not opts.type_hints.show then
          return ""
        end

        return table.concat(labels or {}, "")
      end,
      -- highlight group
      highlight = "Comment",
    },
  },
}
