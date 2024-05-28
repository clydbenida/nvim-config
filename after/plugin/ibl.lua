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
    injected_languages = true,
    enabled = true,
    show_exact_scope = false,
    show_start = false,
    show_end = false,
    include = {
      node_type = { ["*"] = {
        "class",
        "function",
        "method",
        "^if",
        "^while",
        "^for",
        "^object",
        "^table",
        "^type",
        "^import",
        "block",
        "arguments"
      } }
    }
  }
}
