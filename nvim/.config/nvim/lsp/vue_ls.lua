-- Vue 3 server: @vue/language-server v3, Mason-managed, hybrid mode.
--
-- cmd is defined in lua/plugins/lsp.lua as a function: it runs Mason's (auto-updated)
-- vue-language-server binary and passes --tsdk pointing at the PROJECT's classic
-- TypeScript. This is required because the server loads TypeScript from --tsdk, and
-- otherwise falls back to `require("typescript")` -> Mason's bundled TS 7 ("tsgo"),
-- a Go binary with no JS API that crashes the server ("Cannot read properties of
-- undefined (reading 'protocol')"). Passing the project's classic TS both fixes the
-- crash and keeps the server's TypeScript in sync with the project version.
--
-- Actual TypeScript for .ts/.js/.vue is handled by vtsls + @vue/typescript-plugin
-- (see lsp/vtsls.lua); lspconfig's shipped vue_ls `on_init` forwards TS requests to it.
--
-- NOTE: cmd and root_dir (the Vue-3-only version gate) are asserted in
-- lua/plugins/lsp.lua so they win over nvim-lspconfig's shipped lsp/vue_ls.lua.
return {
  filetypes = { "vue" },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
