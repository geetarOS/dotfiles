return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- lazy=false is recommended so oil can hijack netrw on directory open
  lazy = false,
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["<C-h>"] = false,  -- free up if it clashes with window nav
      ["<C-l>"] = false,
    },
  },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
  },
}
