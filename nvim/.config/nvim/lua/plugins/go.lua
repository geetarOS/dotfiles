-- Go-specific tooling only (tests, debug, struct tags, etc.).
-- LSP (gopls), completion, and formatting live in their own files:
--   lua/plugins/lsp.lua, lsp/gopls.lua, lua/plugins/completion.lua, lua/plugins/conform.lua
return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    opts = {
      lsp_cfg = false,      -- gopls is configured in lua/plugins/lsp.lua
      lsp_keymaps = false,  -- keymaps come from the LspAttach autocmd in init.lua
      lsp_inlay_hints = { enable = true },
    },
    config = function(_, opts)
      require("go").setup(opts)
    end,
  },
}
