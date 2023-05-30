local utils = require("utils")

_G.fugitive = {}
_G.fugitive.gac = function()
  local commit_message = vim.fn.input("Commit message: ")
  if not utils.isempty(commit_message) then
    vim.cmd("G commit -am '" .. commit_message .. "'")
  end
end

return {
  "tpope/vim-fugitive",
  config = function()
    utils.noremap("n", "<Leader>gs", "<cmd>G status<CR>")
    utils.noremap("n", "<Leader>gp", "<cmd>G push<CR>")
    utils.noremap("n", "<Leader>gac", ":call v:lua.fugitive.gac()<CR>")
    utils.noremap("n", "<Leader>gaa", "<cmd>G add .<CR>")
  end,
}
