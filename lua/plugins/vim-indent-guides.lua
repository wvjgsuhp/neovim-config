return {
  "nathanaelkane/vim-indent-guides",
  -- build = ":IndentGuidesEnable",
  config = function()
    vim.g.indent_guides_enable_on_vim_startup = 0
    vim.g.indent_guides_default_mapping = 0
    vim.g.indent_guides_tab_guides = 0
    vim.g.indent_guides_color_change_percent = 3
    vim.g.indent_guides_guide_size = 1
    vim.g.indent_guides_exclude_filetypes = {
      "help",
      "man",
      "fern",
      "defx",
      "denite",
      "denite-filter",
      "startify",
      "vista",
      "vista_kind",
      "tagbar",
      "lsp-hover",
      "clap_input",
      "fzf",
      "any-jump",
      "gina-status",
      "gina-commit",
      "gina-log",
      "minimap",
      "quickpick-filter",
      "lsp-quickpick-filter",
      "lspinfo",
    }
    --   vim.cmd([[
    --     augroup user_plugin_indentguides
    --       autocmd!
    --       autocmd BufEnter *
    --         \ if ! empty(&l:filetype) && empty(&buftype) && ! &previewwindow
    --         \|   if g:indent_guides_autocmds_enabled == 0 && &l:expandtab
    --         \|     IndentGuidesEnable
    --         \|   elseif g:indent_guides_autocmds_enabled == 1 && ! &l:expandtab
    --         \|     IndentGuidesDisable
    --         \|   endif
    --         \| elseif g:indent_guides_autocmds_enabled == 1
    --         \|   IndentGuidesDisable
    --         \| endif
    --     augroup END
    --   ]])
  end,
}
