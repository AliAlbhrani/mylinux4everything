require("conform").setup({
  formatters_by_ft = {
    javascript      = { "prettier" },
    javascriptreact = { "prettier" },
    typescript      = { "prettier" },
    typescriptreact = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = false,
  },
})
