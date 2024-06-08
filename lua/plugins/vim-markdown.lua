return {
  "preservim/vim-markdown",
  config = function()
    vim.g.vim_markdown_frontmatter = 1
    vim.g.vim_markdown_strikethrough = 1
    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_conceal = 1
    vim.g.vim_markdown_conceal_code_blocks = 1
    vim.g.vim_markdown_new_list_item_indent = 0
    vim.g.vim_markdown_toc_autofit = 0
    vim.g.vim_markdown_follow_anchor = 0
    vim.g.vim_markdown_no_extensions_in_markdown = 1
    vim.g.vim_markdown_edit_url_in = "vsplit"
    vim.g.vim_markdown_fenced_languages = {
      "c++=cpp",
      "viml=vim",
      "bash=sh",
      "ini=dosini",
      "js=javascript",
      "json=javascript",
      "jsx=javascriptreact",
      "tsx=typescriptreact",
      "docker=Dockerfile",
      "makefile=make",
      "py=python",
      "R=r",
    }

    -- TODO: properly convert to lua
    vim.cmd([[
      augroup md_syntax
        autocmd!
        autocmd FileType markdown set syntax=on
      augroup END
    ]])
  end,
  ft = { "markdown" },
}
