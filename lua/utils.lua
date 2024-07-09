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
function utils.is_empty(str)
  return str == nil or str == ""
end

--- return an empty string if the string is nil
--- @param str string
--- @param default? string
function utils.ensure_string(str, default)
  return str and str or (default and default or "")
end

--- remove highlight groups from a string
--- @param str string
function utils.strip_highlight_groups(str)
  return (str:gsub("%%#%w+#", ""):gsub("%%%*", ""))
end

--- return number of display characters without highlight groups and %\w+
--- @param str string
function utils.display_width(str)
  return vim.fn.strwidth((utils.strip_highlight_groups(str):gsub("%%%w+", "")))
end

--- truncate a string and add a trailing character
--- @param str string
--- @param max_length number
--- @param trailing? string
function utils.truncate(str, max_length, trailing)
  local length = max_length + str:len() - utils.display_width(str)
  return str:sub(1, length) .. (trailing ~= nil and trailing or "")
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
utils.emit_event = vim.api.nvim_exec_autocmds

--- vim autocmd for filetype
--- @param filetype string
--- @param callback function
function utils.autocmd_filetype(filetype, callback)
  utils.autocmd("FileType", {
    pattern = filetype,
    callback = callback,
  })
end

function utils.debug_opened_windows()
  local windows = vim.api.nvim_list_wins()

  for _, current_window in ipairs(windows) do
    -- local buf = vim.api.nvim_win_get_buf(current_window)
    local buf_ft = vim.bo.filetype
    -- local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")
    print(buf_ft)
  end

  return true
end

return utils
