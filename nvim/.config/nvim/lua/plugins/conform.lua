-- ~/.config/nvim/lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofumpt" },
      vue = { "eslint_d" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
    },
    format_on_save = {
      timeout_ms = 5000, -- eslint_d cold-start on large projects can exceed 3s
      lsp_format = "never",
    },
  },
}
