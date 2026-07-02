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
        ensure_installed = { "gopls" },
        automatic_enable = false, -- we call vim.lsp.enable ourselves, explicitly
      })

      -- Give every server nvim-cmp's completion capabilities by default.
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- nvim-lspconfig now ships its own lsp/volar.lua (filetypes = { "vue" })
      -- that loads AFTER ours on the runtimepath and clobbers our filetypes,
      -- so Volar (takeover mode) stopped attaching to .ts/.js. Re-assert here;
      -- an explicit vim.lsp.config() call wins over the runtimepath merge.
      vim.lsp.config("volar", {
        filetypes = { "vue", "javascript", "typescript", "json" },
      })

      -- Turn servers on. Settings for each are merged from ~/.config/nvim/lsp/<name>.lua
      vim.lsp.enable({ "gopls", "volar", "tailwindcss" })
    end,
  },
}
