return {
  "brenoprata10/nvim-highlight-colors",
  opts = {
    ---@usage 'background'|'foreground'|'virtual'
    render = "background",
    -- virtual_symbol = "",
    exclude_filetypes = { "lazy", "mason" },
  },
  ft = {
    "html",
    "css",
    "vim",
    "toml",
    "typescript",
    "javascript",
    "tex",
    "lua",
  },
}
