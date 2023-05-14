local utils = {}

---vim noremap
---@param mode string
---@param shortcut string
---@param command string
function utils.noremap(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { remap = false, silent = true })
end

---vim noremap
---@param mode string
---@param shortcut string
---@param command string
function utils.map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { remap = true, silent = true })
end

return utils
