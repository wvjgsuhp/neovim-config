" highlight on yank
autocmd TextYankPost *
  \ silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
