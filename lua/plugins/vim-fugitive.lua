local utils = require("utils")

local get_commit_message = function()
  local commit_message = vim.fn.input("Commit message: ")
  if not utils.is_empty(commit_message) then
    vim.cmd("Git! commit -am '" .. commit_message .. "'")
  end
end

return {
  "tpope/vim-fugitive",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "G" },
  config = function() end,
  keys = {
    { "<Leader>gp", "<cmd>Git! push<CR>" },
    { "<Leader>gac", get_commit_message },
    { "<Leader>gaa", "<cmd>Git! add .<CR>" },
  },
}
