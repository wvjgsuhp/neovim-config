local utils = {}

--- vim noremap
--- @param mode string
--- @param shortcut string
--- @param command string | function
function utils.noremap(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { remap = false, silent = true })
end

--- vim map
--- @param mode string
--- @param shortcut string
--- @param command string | function
function utils.map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { remap = true, silent = true })
end

--- upper case first character
--- @param str string
function utils.capitalize(str)
  return (str:lower():gsub("^%l", string.upper))
end

--- check if string is empty
--- @param str string
function utils.isempty(str)
  return str == nil or str == ""
end

--- vim augroup
--- @param group string
--- @param opts? table
function utils.augroup(group, opts)
  if opts == nil then
    opts = { clear = true }
  end
  return vim.api.nvim_create_augroup(group, opts)
end

utils.autocmd = vim.api.nvim_create_autocmd

function utils.debug_opened_windows()
  local windows = vim.api.nvim_list_wins()

  for _, current_window in ipairs(windows) do
    local buf = vim.api.nvim_win_get_buf(current_window)
    local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")
    print(buf_ft)

    -- local local_return = false
    -- for _, ft_to_bypass in ipairs(file_types_to_bypass) do
    --     if buf_ft == ft_to_bypass then
    --         local_return = true
    --         break
    --     end
    -- end

    -- if local_return == false then
    --     return false
    -- end
  end

  return true
end

return utils
