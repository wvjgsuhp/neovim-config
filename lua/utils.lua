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
  end

  return true
end

--- merge two tables with values from `table_2` overriding values from `table_1`
--- @param table_1 table
--- @param table_2 table
utils.merge_tables = function(table_1, table_2)
  local merged_table = {}
  for k, v in pairs(table_1) do
    merged_table[k] = v
  end
  for k, v in pairs(table_2) do
    merged_table[k] = v
  end

  return merged_table
end

return utils
