local utils = {}

---vim noremap
---@param mode string
---@param shortcut string
---@param command string
function utils.noremap(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

return utils
