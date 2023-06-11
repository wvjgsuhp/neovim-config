local utils = require("utils")

local get_commit_message = function()
  local commit_message = vim.fn.input("Commit message: ")
  if not utils.isempty(commit_message) then
    vim.cmd("G commit -am '" .. commit_message .. "'")
  end
end

return {
  "tpope/vim-fugitive",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<Leader>gs", "<cmd>G status<CR>" },
    { "<Leader>gp", "<cmd>G push<CR>" },
    { "<Leader>gac", get_commit_message },
    { "<Leader>gaa", "<cmd>G add .<CR>" },
  },
}
