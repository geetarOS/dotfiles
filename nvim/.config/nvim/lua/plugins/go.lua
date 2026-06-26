-- ~/.config/nvim/lua/plugins/go.lua
return {
  -- gopls + Mason
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls" },
      })

      local caps = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("gopls", {
        capabilities = caps,
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            analyses = { unusedparams = true, nilness = true, unusedwrite = true },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })
      vim.lsp.enable("gopls")
    end,
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- conform for formatting on save (gofumpt + goimports)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
      },
      format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
    },
  },

  -- go.nvim: Go-specific commands (test, debug, struct tags, etc.)
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lsp_cfg = false,       -- you configure gopls yourself above
      lsp_keymaps = false,
      lsp_inlay_hints = { enable = true },
    },
    config = function(_, opts)
      require("go").setup(opts)
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
}
