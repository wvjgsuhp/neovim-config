return {
  settings = {
    Lua = {
      diagnostics = {
        -- suppress global vim warning
        globals = { "vim" },
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}
