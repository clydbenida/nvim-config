require("ibl").setup {
  indent = {
    char = "▏",
  },
  whitespace = {
    remove_blankline_trail = false,
  },
  exclude = {
    buftypes = { "terminal" },
    filetypes = { "help", "terminal", "lua" },
  },
  scope = {
    enabled = true,
    show_exact_scope = true,
    include = {
      node_type = { ["*"] = { "*" } }
    }
  }
}
