return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ensure_installed = { "lua", "vim", "vimdoc", "bash", "markdown", "markdown_inline" }
      local installed = require("nvim-treesitter.config").get_installed()
      local missing = vim.iter(ensure_installed)
        :filter(function(p) return not vim.tbl_contains(installed, p) end)
        :totable()
      if #missing > 0 then
        require("nvim-treesitter").install(missing)
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang or not vim.tbl_contains(
            require("nvim-treesitter.config").get_installed(), lang) then
            return
          end
          pcall(vim.treesitter.start)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
