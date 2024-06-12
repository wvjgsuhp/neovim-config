return {
  "tpope/vim-fugitive",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "G" },
  config = function()
    local utils = require("utils")

    local get_commit_message = function()
      local commit_message = vim.fn.input("Commit message: ")
      if not utils.is_empty(commit_message) then
        vim.cmd("G commit -am '" .. commit_message .. "'")
      end
    end

    utils.noremap("n", "<Leader>gp", "<cmd>Git! push<CR>")
    utils.noremap("n", "<Leader>gac", get_commit_message)
    utils.noremap("n", "<Leader>gaa", "<cmd>Git! add .<CR>")
  end,
}
