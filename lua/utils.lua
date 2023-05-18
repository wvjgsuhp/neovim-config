local utils = {}

---vim noremap
---@param mode string
---@param shortcut string
---@param command string
function utils.noremap(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { remap = false, silent = true })
end

---vim map
---@param mode string
---@param shortcut string
---@param command string
function utils.map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { remap = true, silent = true })
end

---upper case first character
---@param str string
function utils.capitalize(str)
  return (str:lower():gsub("^%l", string.upper))
end

return utils
