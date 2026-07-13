-- TypeScript server for Vue 3 projects (hybrid mode).
--
-- Loads @vue/typescript-plugin from the Mason-managed vue-language-server package
-- so the plugin always tracks the same version as the Vue 3 language server.
--
-- NOTE: filetypes (adds "vue" for cross-file type info) and root_dir (the
-- Vue-3-only version gate) are asserted in lua/plugins/lsp.lua so they win over
-- nvim-lspconfig's shipped lsp/vtsls.lua.
local vue_ls_pkg = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server"

return {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  settings = {
    vtsls = {
      -- Use the project's own TypeScript (node_modules) instead of vtsls's bundled
      -- copy, so type-checking matches the project version -- same as vue_ls's tsdk.
      autoUseWorkspaceTsdk = true,
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_ls_pkg .. "/node_modules/@vue/typescript-plugin",
            languages = { "vue" },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
  },
}
