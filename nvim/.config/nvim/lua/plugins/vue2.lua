-- ~/.config/nvim/lua/plugins/vue2.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()

      local caps = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("volar", {
        capabilities = caps,
        filetypes = { "vue", "javascript", "typescript", "json" },
        on_attach = function(client, bufnr)
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
      })

      vim.lsp.enable("volar")
      
      vim.lsp.config("tailwindcss", {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
      vim.lsp.enable("tailwindcss")    
    end,
  },
}
