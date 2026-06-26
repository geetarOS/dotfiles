vim.lsp.config("tailwindcss", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
vim.lsp.enable("tailwindcss")
