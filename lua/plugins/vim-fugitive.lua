local utils = require("utils")

local get_commit_message = function ()
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
    utils.noremap("n", "<Leader>gac", get_commit_message)
    utils.noremap("n", "<Leader>gaa", "<cmd>G add .<CR>")
  end,
}
