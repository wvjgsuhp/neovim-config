return {
  "t9md/vim-choosewin",
  config = function()
    vim.cmd([[
      let g:choosewin_label = 'ADFGHJKLUIOPQWERT'
      let g:choosewin_label_padding = 5

      nmap -         <Plug>(choosewin)
      nmap <Leader>- <cmd>ChooseWinSwapStay<CR>
    ]])
  end,
}
