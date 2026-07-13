-- LSP core: server management + native vim.lsp config/enable.
-- Per-server settings live in ~/.config/nvim/lsp/<name>.lua (nvim 0.11+ native dir).
-- IMPORTANT: this is the ONLY place that owns the nvim-lspconfig `config` function.
-- Do not add a second nvim-lspconfig `config` in another file, or they clobber each other.
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "vtsls", "vue_ls" },
        automatic_enable = false, -- we call vim.lsp.enable ourselves, explicitly
      })

      -- Give every server nvim-cmp's completion capabilities by default.
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Vue 2 vs Vue 3 routing. Each server gets a root_dir "gate" (see
      -- lua/util/vue_version.lua) so it only attaches in projects of its major
      -- version. All three are enabled at once; the gate does the routing.
      --
      -- These keys are asserted HERE (not just in ~/.config/nvim/lsp/<name>.lua)
      -- because nvim-lspconfig ships its own lsp/volar.lua, lsp/vue_ls.lua and
      -- lsp/vtsls.lua that load AFTER ours on the runtimepath and would clobber
      -- filetypes/cmd/root_dir. An explicit vim.lsp.config() call wins.
      local vue = require("util.vue_version")

      -- Vue 2: frozen Volar 1.8.27 (takeover mode), side-installed under <data>/vue2-ls.
      vim.lsp.config("volar", {
        cmd = {
          vim.fn.stdpath("data") .. "/vue2-ls/node_modules/.bin/vue-language-server",
          "--stdio",
        },
        filetypes = { "vue", "javascript", "typescript", "json" },
        root_dir = vue.gate(2),
      })

      -- Vue 3: @vue/language-server v3 (hybrid mode), Mason-managed + auto-updated.
      -- vue_ls only translates .vue SFCs into virtual TS and forwards the real type
      -- questions to vtsls -- so the PROJECT's TypeScript version is vtsls's concern
      -- (autoUseWorkspaceTsdk, see lsp/vtsls.lua), NOT vue_ls's. vue_ls just needs
      -- *some* classic TypeScript to boot: without --tsdk it falls back to its bundled
      -- copy, which via Mason is TS 7 ("tsgo") -- a Go binary with no JS API that
      -- crashes it. So we point --tsdk at the frozen classic TS 5 (a fixed, always-
      -- present path); its exact version is immaterial since vtsls does the checking.
      vim.lsp.config("vue_ls", {
        cmd = {
          vim.fn.stdpath("data") .. "/mason/bin/vue-language-server",
          "--stdio",
          "--tsdk=" .. vim.fn.stdpath("data") .. "/vue2-ls/node_modules/typescript/lib",
        },
        root_dir = vue.gate(3),
      })

      -- Vue 3: vtsls handles .ts/.js and .vue cross-file types via @vue/typescript-plugin.
      vim.lsp.config("vtsls", {
        filetypes = {
          "typescript",
          "javascript",
          "typescriptreact",
          "javascriptreact",
          "vue",
        },
        root_dir = vue.gate(3),
      })

      -- Turn servers on. Settings for each are merged from ~/.config/nvim/lsp/<name>.lua
      vim.lsp.enable({ "gopls", "volar", "vue_ls", "vtsls", "tailwindcss" })
    end,
  },
}
