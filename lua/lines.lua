-- https://www.reddit.com/r/neovim/comments/vpxexc/pde_custom_winbar_and_statusline_without_plugins/
local M = {}
local utils = require("utils")
local constants = require("constants")

local winbar_exclude_file_types = {
  alpha = true,
  dashboard = true,
  TelescopePrompt = true,
}

local darker_background_file_types = {
  noice = true,
}

local default_mode_colors = {
  a = "%#StatusLine#",
  b = "%#StatusLine#",
  c = "%#StatusLineN3#",
  record = "%#StatusLine#",
  inactive = "%#StatusLineInactive#",
}

--- @param mode string
local function get_mode_colors(mode)
  local mode_char = mode:sub(1, 1)

  if mode_char == "T" then
    mode_char = "C"
  end

  return {
    a = "%#StatusLine" .. mode_char .. "1#",
    b = "%#StatusLine" .. mode_char .. "2#",
    c = "%#StatusLine" .. mode_char .. "3#",
    record = "%#StatusLine" .. mode_char .. "2Record#",
    inactive = "%#StatusLineInactive#",
  }
end

-- stylua: ignore
local cache_icons = {
  -- custom icons here
  NvimTree  = "",
  terminal  = "",
  Trouble   = "",
  r         = "󰟔 ",
  noice     = "󰚢",
  help      = "󰮥",
  pem       = "󰄤 ",
}

local function get_icon()
  local buftype = vim.bo.buftype
  local filetype = vim.bo.filetype

  if utils.is_empty(buftype) then
    if vim.bo.modified then
      return " %#WinBarModified# %*"
    end

    local icon = cache_icons[filetype]
    if not icon then
      local filename = vim.fn.expand("%:t")
      local extension = vim.fn.fnamemodify(filename, ":e")
      local file_icon, hl_group = require("nvim-web-devicons").get_icon(filename, extension)
      if file_icon == nil then
        return ""
      end

      icon = " " .. "%#" .. hl_group .. "#" .. file_icon .. " %*"
      cache_icons[filename] = icon

      return icon
    end
  end

  local default_icon_hl = darker_background_file_types[filetype] and " %#WinBarIconDarker#" or " %#WinBarIcon#"
  if buftype == "terminal" then
    return default_icon_hl .. cache_icons.terminal .. "%*"
  end

  local icon = cache_icons[filetype]
  return icon and (default_icon_hl .. icon .. "%*") or ""
end

local function get_location()
  local success, result = pcall(function()
    if not vim.w.is_current then
      return ""
    end

    local provider = require("nvim-navic")
    if not provider.is_available() then
      return ""
    end

    local location = provider.get_location({})
    if not utils.is_empty(location) and location ~= "error" then
      return constants.win_bar_separator .. location
    else
      return ""
    end
  end)

  return success and result or ""
end

local branch_mapping = {
  feature = " ",
  bugfix = " ",
  hotfix = " ",
}

-- https://www.reddit.com/r/neovim/comments/uz3ofs/heres_a_function_to_grab_the_name_of_the_current/
local function get_branch_name()
  local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
  if utils.is_empty(branch) then
    return "   ❮not-a-repo❯ "
  else
    for prefix, icon in pairs(branch_mapping) do
      local pattern = "^" .. prefix
      if branch:match(pattern) then
        branch = branch:gsub(pattern, icon)
        break
      end
    end

    branch = utils.truncate(branch, 21)
    return " 󰙁 " .. branch .. " "
  end
end

M.get_winbar = function()
  -- floating window
  local cfg = vim.api.nvim_win_get_config(0)
  if cfg.relative > "" or cfg.external then
    return ""
  end
  local filetype = vim.bo.filetype
  if winbar_exclude_file_types[filetype] then
    return ""
  end

  local mode_part = utils.ensure_string(vim.w.mode_part)
  local icon = utils.ensure_string(vim.b.icon)

  local buftype = vim.bo.buftype
  if buftype == "terminal" then
    return table.concat({
      mode_part,
      icon,
      " TERMINAL-%n" .. constants.win_bar_separator .. "%{b:term_title}",
      "%=",
      vim.w.tabs,
    })
  elseif buftype == "nofile" then
    local background = darker_background_file_types[filetype] and "%#Pmenu#" or ""
    return table.concat({
      mode_part,
      background,
      icon,
      background,
      " " .. filetype,
    })
  else
    -- real files do not have buftypes
    if utils.is_empty(buftype) then
      return table.concat({
        mode_part,
        vim.b.filename,
        "%<",
        get_location(),
        "%=",
        vim.w.tabs,
      })
    else
      -- Meant for quickfix, help, etc
      return mode_part .. "%( %h%) %f"
    end
  end
end

local fill_char = "─"
M.get_status_line = function()
  local mode_colors = vim.w.mode_colors and vim.w.mode_colors or default_mode_colors
  local relative_path = utils.ensure_string(vim.b.relative_path)
  local modify_status = utils.ensure_string(vim.b.modify_status)
  local line_column = utils.ensure_string(vim.w.line_column)

  local max_chars_half = (vim.o.columns - utils.display_width(relative_path)) / 2

  if vim.w.is_current then
    -- left
    local branch_name = utils.ensure_string(vim.b.branch_name)
    local recording = utils.ensure_string(vim.g.recording)
    local language_servers = utils.ensure_string(vim.b.language_servers)
    local filetype = " 󰔰 " .. vim.bo.filetype
    local git_signs = utils.ensure_string(vim.b.git_signs)

    -- right
    local diags = utils.ensure_string(vim.b.diags)
    local ai_completion = utils.ensure_string(vim.b.ai_completion)
    local date = os.date(" 󰥔 %H:%M ")

    local max_chars_left = math.floor(max_chars_half)
    local max_chars_right = math.ceil(max_chars_half)

    local n_empty_left = max_chars_left
      - utils.display_width(branch_name .. recording .. language_servers .. filetype .. git_signs)
    local n_empty_right = max_chars_right
      - (vim.w.number_width or 0)
      - utils.display_width(modify_status .. diags .. ai_completion .. date .. line_column)

    local left_fill
    local right_fill
    if utils.is_empty(relative_path) then
      left_fill = " " .. fill_char:rep(n_empty_left - 1)
      right_fill = fill_char:rep(n_empty_right - 1) .. " "
    else
      left_fill = " " .. fill_char:rep(n_empty_left - 2) .. " "
      right_fill = " " .. fill_char:rep(n_empty_right - 2) .. " "
    end

    return table.concat({
      -- left
      mode_colors.a,
      branch_name,
      mode_colors.record,
      recording,
      mode_colors.c,
      language_servers,
      filetype,
      left_fill,

      -- middle
      "%=",
      git_signs,
      mode_colors.c,
      relative_path,
      modify_status,
      diags,
      mode_colors.c,
      "%=",
      right_fill,

      -- right
      ai_completion,
      mode_colors.b,
      date,
      mode_colors.a,
      line_column,
    })
  else
    return table.concat({
      "%<",
      mode_colors["inactive"],
      relative_path,
      modify_status,
      "%=",
      line_column,
    })
  end
end

-- local line_icons = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
local line_icons = { "⡀", "⣀", "⣄", "⣤", "⣦", "⣶", "⣾", "⣿" }
local function get_line_column()
  local current_line = vim.fn.line(".")
  local total_line = vim.fn.line("$")

  local n_line_digits = math.floor(math.log10(total_line)) + 1
  local n_column_digits = math.floor(math.log10(vim.o.columns)) + 1

  local icon_index = math.floor(current_line / total_line * (#line_icons - 1)) + 1
  return {
    line_column = " %"
      .. n_line_digits
      .. "l/%L"
      .. line_icons[icon_index]
      .. " %"
      .. n_column_digits
      .. "c󰤼 %*",
    number_width = 2 * n_line_digits + n_column_digits,
  }
end

-- mode_map copied from:
-- https://github.com/nvim-lualine/lualine.nvim/blob/5113cdb32f9d9588a2b56de6d1df6e33b06a554a/lua/lualine/utils/mode.lua
-- Copyright (c) 2020-2021 hoob3rt
-- MIT license, see LICENSE for more details.
-- stylua: ignore
local mode_map = {
  ["n"]     = "N",
  ["no"]    = "N",
  ["nov"]   = "N",
  ["noV"]   = "N",
  ["no\22"] = "N",
  ["niI"]   = "N",
  ["niR"]   = "N",
  ["niV"]   = "N",
  ["nt"]    = "N",
  ["v"]     = "V",
  ["vs"]    = "V",
  ["V"]     = "V",
  ["Vs"]    = "V",
  ["\22"]   = "V",
  ["\22s"]  = "V",
  ["s"]     = "S",
  ["S"]     = "S",
  ["\19"]   = "S",
  ["i"]     = "I",
  ["ic"]    = "I",
  ["ix"]    = "I",
  ["R"]     = "R",
  ["Rc"]    = "R",
  ["Rx"]    = "R",
  ["Rv"]    = "R",
  ["Rvc"]   = "R",
  ["Rvx"]   = "R",
  ["c"]     = "C",
  ["cv"]    = "C",
  ["ce"]    = "C",
  ["r"]     = "R",
  ["rm"]    = "MORE",
  ["r?"]    = "CONFIRM",
  ["!"]     = "SHELL",
  ["t"]     = "T",
}

local mode_icons = {
  -- N = "󰜱󰜴",
  -- I = " ",
  -- V = " ",
  -- R = "󰯍 ",
  -- T = " ",
  -- C = " ",
  N = "󰎐",
  I = "󰷈",
  V = "󰩬",
  R = "󰙩",
  T = "",
  C = "󰇘",
}

local function get_filename()
  local has_icon, icon = pcall(get_icon)
  if has_icon and not utils.is_empty(icon) then
    return icon .. "%t"
  else
    return " %t"
  end
end

local severity_levels = { "Error", "Warn", "Info", "Hint" }
local diagnostic_signs = constants.icons.diagnostics

--- @param severity string
local function get_sign(severity)
  local hl = "%#StatusLine" .. severity .. "#"
  return hl .. diagnostic_signs[severity:lower()] .. " "
end

local function get_diags()
  local d = vim.diagnostic.get(0)
  if #d == 0 then
    return ""
  end

  local grouped = {}
  for _, diag in ipairs(d) do
    local severity = diag.severity
    if severity == nil then
    elseif grouped[severity] then
      grouped[severity] = grouped[severity] + 1
    else
      grouped[severity] = 1
    end
  end

  local result = ""
  local severity = vim.diagnostic.severity
  for _, level in ipairs(severity_levels) do
    local severity_count = grouped[severity[level:upper()]]
    if severity_count then
      result = result .. " " .. get_sign(level) .. severity_count
    end
  end

  return result
end

local use_git_changes = { "added", "removed", "changed" }
local git_signs = constants.icons.git_signs

local function get_git_signs()
  local changes = ""
  if not utils.is_empty(vim.b.gitsigns_status_dict) then
    for _, change in ipairs(use_git_changes) do
      local sign = git_signs[change]
      local change_count = vim.b.gitsigns_status_dict[change]
      if change_count and change_count > 0 then
        local hl = "%#StatusLineGit" .. utils.capitalize(change) .. "#"
        changes = changes .. hl .. sign .. tostring(change_count) .. " "
      end
    end
  end

  return changes
end

--- @param mode string
local function get_tabs(mode)
  -- uncomment to display tabs in |1|2|...
  -- if mode:len() > 1 then
  --   return ""
  -- end

  local last_tab = vim.fn.tabpagenr("$")
  if last_tab == 1 then
    return ""
  end

  -- local mode_colors = M.get_mode_colors(mode)
  local this_tab = vim.fn.tabpagenr()
  -- return " " .. mode_colors["a"] .. " " .. tostring(this_tab) .. "/" .. tostring(last_tab) .. " "
  -- local tabs = " "
  -- for tab = 1, last_tab, 1 do
  --   if tab ~= this_tab then
  --     tabs = tabs .. "%#StatusLineInactive# " .. tostring(tab) .. " %*"
  --   else
  --     tabs = tabs .. mode_colors["a"] .. " " .. tostring(tab) .. " %*"
  --   end
  -- end
  --
  -- return tabs

  return "  " .. tostring(this_tab) .. "/" .. tostring(last_tab)
end

local function get_relative_path()
  local buftype = vim.bo.buftype
  if buftype == "terminal" then
    return "terminal"
  elseif buftype == "nofile" or buftype == "prompt" then
    return vim.bo.filetype
  end

  local file = vim.fn.expand("%:.")

  local is_modifiable = vim.api.nvim_get_option_value("modifiable", { buf = 0 })
  if vim.bo.readonly or not is_modifiable then
    local color = ""
    if vim.w.is_current then
      color = "%#StatusLineRO#"
    end
    return color .. file .. " "
  end

  -- local is_modified = vim.api.nvim_get_option_value("modified", { buf = 0 })
  -- if is_modified then
  --   return file .. "  "
  -- end
  return file:sub(1, -1)
end

local function get_modify_status()
  if utils.is_empty(vim.b.relative_path) then
    return ""
  end

  local is_modified = vim.api.nvim_get_option_value("modified", { buf = 0 })
  if is_modified then
    return "  "
  end
end

--- @param text string
--- @param color string
local function paint(text, color)
  return text ~= "" and (color .. text .. "%*") or ""
end

--- @param mode string
local function get_mode_part(mode)
  if vim.fn.strdisplaywidth(mode) > 1 then
    return mode
  end

  return paint(" " .. (mode_icons[mode] or mode) .. " ", vim.w.mode_colors["a"])
end

local minimal_status_line_file_types = vim.tbl_deep_extend("force", winbar_exclude_file_types, {
  [""] = true,
  lazy = true,
  help = true,
  NvimTree = true,
  checkhealth = true,
  Trouble = true,
  noice = true,
  fugitiveblame = true,
})

local function is_minimal()
  return minimal_status_line_file_types[vim.bo.filetype] or vim.bo.buftype == "terminal"
end

local function get_recording()
  local recording_register = vim.fn.reg_recording()
  return utils.is_empty(recording_register) and "" or ("  " .. recording_register .. " ")
end

local function get_language_servers()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local servers = {}
  for _, client in ipairs(clients) do
    table.insert(servers, client.name)
  end

  if #servers > 0 then
    return "   " .. table.concat(servers, ", ")
  end

  return ""
end

local function get_mode()
  if not vim.w.is_current then
    return "%#StatusLineInactive# " .. vim.fn.winnr() .. " %*"
  end

  local mode_code = vim.api.nvim_get_mode().mode
  local mode = mode_map[mode_code] or string.upper(mode_code)
  return mode
end

local function has_ai_completion()
  local ai_completions = { "supermaven-nvim" }
  for _, ai_completion in ipairs(ai_completions) do
    if package.loaded[ai_completion] then
      return true
    end
  end

  return false
end

local function get_ai_completion()
  local ai_completion = ""

  -- supermaven
  --
  local is_exist, supermaven = pcall(require, "supermaven-nvim.api")
  if is_exist and supermaven.is_running() then
    ai_completion = "supermaven"
  end

  if ai_completion ~= "" then
    return "  " .. ai_completion .. " "
  else
    return ""
  end
end

local status_line_group = utils.augroup("status_line")

utils.autocmd({ "WinEnter", "BufEnter" }, {
  group = status_line_group,
  callback = function()
    vim.w.is_current = true
    vim.b.is_buffer_minimal = is_minimal()
    vim.b.icon = get_icon()
  end,
})

utils.autocmd({ "ModeChanged", "WinEnter", "BufEnter", "WinLeave", "BufLeave" }, {
  group = status_line_group,
  callback = function()
    vim.w.mode = get_mode()
    vim.w.mode_colors = get_mode_colors(vim.w.mode)
    vim.w.mode_part = get_mode_part(vim.w.mode)

    vim.schedule(function()
      vim.w.mode = get_mode()
      vim.w.mode_colors = get_mode_colors(vim.w.mode)
      vim.w.mode_part = get_mode_part(vim.w.mode)
    end)
  end,
})

utils.autocmd({ "WinLeave", "BufLeave" }, {
  group = status_line_group,
  callback = function()
    vim.w.is_current = false
  end,
})

utils.autocmd({ "CursorMoved", "CursorMovedI", "WinEnter", "BufEnter", "BufWritePost" }, {
  group = status_line_group,
  callback = function()
    vim.b.filename = get_filename()
    vim.b.modify_status = get_modify_status()
  end,
})

utils.autocmd("CursorMoved", {
  group = status_line_group,
  callback = function()
    local line_column = get_line_column()
    vim.w.line_column = line_column.line_column
    vim.w.number_width = line_column.number_width
  end,
})

utils.autocmd({ "WinEnter", "BufEnter", "CmdlineLeave" }, {
  group = status_line_group,
  callback = vim.schedule_wrap(function()
    vim.b.branch_name = get_branch_name()
  end),
})

utils.autocmd({ "LSPAttach", "WinEnter", "BufEnter" }, {
  group = status_line_group,
  callback = function()
    vim.b.language_servers = get_language_servers()
  end,
})

utils.autocmd({ "WinEnter", "BufEnter" }, {
  group = status_line_group,
  callback = function()
    vim.w.tabs = get_tabs(vim.w.mode)
  end,
})

utils.autocmd({ "DiagnosticChanged", "WinEnter", "BufEnter" }, {
  group = status_line_group,
  callback = function()
    vim.b.diags = get_diags()
  end,
})

utils.autocmd("User", {
  group = status_line_group,
  pattern = "GitSignsUpdate",
  callback = function()
    vim.b.git_signs = get_git_signs()
  end,
})

utils.autocmd({ "RecordingEnter" }, {
  group = status_line_group,
  callback = function()
    vim.g.recording = get_recording()
  end,
})

utils.autocmd({ "RecordingLeave" }, {
  group = status_line_group,
  callback = function()
    vim.g.recording = ""
  end,
})

utils.autocmd("User", {
  group = status_line_group,
  pattern = "AICompletionStarted",
  callback = function()
    vim.b.ai_completion = get_ai_completion()
  end,
})

utils.autocmd({ "BufReadPre", "BufNewFile" }, {
  group = status_line_group,
  callback = function()
    vim.b.branch_name = get_branch_name()
    vim.b.git_signs = get_git_signs()
    vim.b.relative_path = get_relative_path()

    if has_ai_completion() then
      vim.b.ai_completion = get_ai_completion()
    end
  end,
})

_G.status = M
vim.o.winbar = "%{%v:lua.status.get_winbar()%}"
vim.o.statusline = "%{%v:lua.status.get_status_line()%}"

return M
