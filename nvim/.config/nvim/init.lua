-- Set up options
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.cmd("colorscheme retrobox")

-- Auto commands
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) 
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    -- Custom gd for Vue template (doesn't work unless on import)
    vim.keymap.set("n", "gD", function()
      -- grab the word under cursor (the component tag name)
      local word = vim.fn.expand("<cword>")
      -- search the buffer for its import line, wrapping around the file
      local found = vim.fn.search("import\\s\\+\\zs" .. word, "w")
      if found > 0 then
        -- now on the import line; run real LSP definition (works from imports)
        vim.lsp.buf.definition()
      else
        vim.notify("No import found for " .. word, vim.log.levels.WARN)
      end
    end, { buffer = args.buf, desc = "Go to component definition (via import)" })
  end,
})

-- Load plugins
require("config.lazy")
