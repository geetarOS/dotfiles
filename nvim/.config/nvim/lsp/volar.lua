-- Vue 2 server: Volar 1.8.27, takeover mode.
--
-- Installed OUTSIDE Mason (side-install) so Mason is free to move the
-- `vue-language-server` package to the latest v3 line for Vue 3 projects
-- without ever disturbing this frozen Vue 2 setup:
--   npm install --prefix <data>/vue2-ls @vue/language-server@1.8.27 typescript@5
--
-- NOTE: cmd, filetypes and root_dir (the Vue-2-only version gate) are asserted
-- in lua/plugins/lsp.lua so they win over nvim-lspconfig's shipped lsp/volar.lua,
-- which loads after this file on the runtimepath and would otherwise clobber them.
local frozen = vim.fn.stdpath("data") .. "/vue2-ls/node_modules"

return {
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
      tsdk = frozen .. "/typescript/lib",
    },
  },
}
