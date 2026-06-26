-- ~/.config/nvim/lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      vue = { "eslint_d" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
    },
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "never",
    },
  },
}
