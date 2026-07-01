-- Vue (volar) in takeover mode for Vue 2.
return {
  filetypes = { "vue", "javascript", "typescript", "json" },
  on_attach = function(client, bufnr)
    -- let conform/eslint own formatting, not the LSP
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  init_options = {
    vue = {
      hybridMode = false, -- takeover mode; required for Vue 2
    },
    typescript = {
      tsdk = vim.fn.stdpath("data")
        .. "/mason/packages/vue-language-server/node_modules/typescript/lib",
    },
  },
}
