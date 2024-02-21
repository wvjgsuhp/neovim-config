-- https://www.reddit.com/r/neovim/comments/vpxexc/pde_custom_winbar_and_statusline_without_plugins/
local M = {}
local utils = require("utils")
local constants = require("constants")

local function is_current()
  local winid = vim.g.actual_curwin
  if utils.isempty(winid) then
    return false
  else
    return winid == tostring(vim.api.nvim_get_current_win())
  end
end

local winbar_exclude_file_types = {
  alpha = true,
  TelescopePrompt = true,
}

local darker_background_file_types = {
  noice = true,
}

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

  local mode = M.get_mode()
  local mode_part = M.get_mode_part(mode)

  local buftype = vim.bo.buftype
  if buftype == "terminal" then
    return table.concat({
      mode_part,
      M.get_icon(),
      " TERMINAL-%n" .. constants.win_bar_separator .. "%{b:term_title}",
      "%=",
      M.get_tabs(mode),
    })
  elseif buftype == "nofile" then
    local background = darker_background_file_types[filetype] and "%#Pmenu#" or ""
    return table.concat({
      mode_part,
      background,
      M.get_icon(),
      background,
      " " .. filetype,
    })
  else
    -- real files do not have buftypes
    if utils.isempty(buftype) then
      return table.concat({
        mode_part,
        M.get_filename(),
        "%<",
        M.get_location(),
        "%=",
        M.get_tabs(mode),
      })
    else
      -- Meant for quickfix, help, etc
      return mode_part .. "%( %h%) %f"
    end
  end
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

M.get_status_line = function()
  local mode = M.get_mode()
  local mode_color = M.get_mode_colors(mode)

  local relative_path = M.get_relative_path()
  local line_icon = M.get_line_icon()
  local lines_columns = " %3l/%L" .. line_icon .. " %3c󰤼 %*"

  local is_buffer_minimal = is_minimal()

  if is_current() then
    local parts = {
      -- left
      mode_color["a"],
      is_buffer_minimal and "" or M.get_git_branch(),
      mode_color["b"],
      M.get_recording(),
      mode_color["c"],
      is_buffer_minimal and "" or M.get_language_servers(),

      -- middle
      "%=",
      is_buffer_minimal and "" or M.get_git_changes(),
      mode_color["c"],
      relative_path,
      is_buffer_minimal and "" or M.get_diags(),
      mode_color["c"],
      "%=",

      -- right
      mode_color["b"],
      os.date(" 󰥔 %H:%M "),
      mode_color["a"],
      lines_columns,
    }
    return table.concat(parts)
  else
    local parts = {
      "%<",
      mode_color["inactive"],
      relative_path,
      "%=",
      lines_columns,
    }
    return table.concat(parts)
  end
end

-- local line_icons = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
local line_icons = { "⡀", "⣀", "⣄", "⣤", "⣦", "⣶", "⣾", "⣿" }
M.get_line_icon = function()
  local current_line = vim.fn.line(".")
  local total_line = vim.fn.line("$")
  local icon_index = math.floor(current_line / total_line * (#line_icons - 1)) + 1
  return line_icons[icon_index]
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
  ["R"]     = "REPLACE",
  ["Rc"]    = "REPLACE",
  ["Rx"]    = "REPLACE",
  ["Rv"]    = "V-REPLACE",
  ["Rvc"]   = "V-REPLACE",
  ["Rvx"]   = "V-REPLACE",
  ["c"]     = "C",
  ["cv"]    = "C",
  ["ce"]    = "C",
  ["r"]     = "REPLACE",
  ["rm"]    = "MORE",
  ["r?"]    = "CONFIRM",
  ["!"]     = "SHELL",
  ["t"]     = "T",
}

local mode_icons = {
  -- N = "󰜱󰜴",
  -- I = " ",
  -- V = " ",
  -- T = " ",
  N = "󰎐",
  I = "󰷈",
  V = "󰩬",
  T = "",
}

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

M.get_icon = function()
  local buftype = vim.bo.buftype
  local filetype = vim.bo.filetype

  if utils.isempty(buftype) then
    if vim.bo.modified then
      return " %#WinBarModified# %*"
    end

    local icon = cache_icons[filetype]
    if not icon then
      local filename = vim.fn.expand("%:t")
      local extension = vim.fn.fnamemodify(filename, ":e")
      local file_icon, hl_group = require("nvim-web-devicons").get_icon(filename, extension)
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
  if not icon then
    return ""
  end
  return default_icon_hl .. icon .. "%*"
end

M.get_filename = function()
  local has_icon, icon = pcall(M.get_icon)
  if has_icon then
    return icon .. "%t"
  else
    return " %t"
  end
end

local severity_levels = { "Error", "Warn", "Info", "Hint" }
local diagnostic_signs = constants.diagnostics

local function get_sign(severity)
  local hl = "%#StatusLine" .. severity .. "#"
  return hl .. diagnostic_signs[severity] .. " "
end

M.get_diags = function()
  local d = vim.diagnostic.get(0)
  if #d == 0 then
    return ""
  end

  local grouped = {}
  for _, diag in ipairs(d) do
    local severity = diag.severity
    if not grouped[severity] then
      grouped[severity] = 0
    end
    grouped[severity] = grouped[severity] + 1
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

M.get_git_branch = function()
  local branch = vim.fn.FugitiveStatusline():sub(6, -3)
  if utils.isempty(branch) then
    return ""
  else
    return " 󰙁 " .. branch .. " "
  end
end

local use_git_changes = { "added", "removed", "changed" }
local git_changes = {
  added = "󰐖 ",
  removed = "󰍵 ",
  changed = "󰏬 ",
}

M.get_git_changes = function()
  local changes = ""
  if not utils.isempty(vim.b.gitsigns_status_dict) then
    for _, change in ipairs(use_git_changes) do
      local sign = git_changes[change]
      local change_count = vim.b.gitsigns_status_dict[change]
      if change_count and change_count > 0 then
        local hl = "%#StatusLineGit" .. utils.capitalize(change) .. "# "
        changes = changes .. hl .. sign .. tostring(change_count)
      end
    end
  end

  return changes
end

M.get_location = function()
  local success, result = pcall(function()
    if not is_current() then
      return ""
    end
    local provider = require("nvim-navic")
    if not provider.is_available() then
      return ""
    end

    local location = provider.get_location({})
    if not utils.isempty(location) and location ~= "error" then
      return constants.win_bar_separator .. location
    else
      return ""
    end
  end)

  if not success then
    return ""
  end
  return result
end

--- @param mode string
M.get_tabs = function(mode)
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

M.get_recording = function()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return " recording  " .. recording_register .. " "
  end
end

M.get_relative_path = function()
  if vim.bo.buftype == "terminal" then
    return " terminal"
  elseif vim.bo.buftype == "nofile" then
    return " " .. vim.bo.filetype
  end

  -- local file = " %f"
  -- local file = " %{expand('%:~:.')}"
  local file = " " .. vim.fn.expand("%:.")

  local is_modifiable = vim.api.nvim_buf_get_option(0, "modifiable")
  if vim.bo.readonly or not is_modifiable then
    local color = ""
    if is_current() then
      color = "%#StatusLineRO#"
    end
    return color .. file .. " "
  end

  local is_modified = vim.api.nvim_buf_get_option(0, "modified")
  if is_modified then
    return file .. "  "
  end
  return file:sub(1, -1)
end

M.get_language_servers = function()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  local servers = {}
  for _, client in ipairs(clients) do
    table.insert(servers, client.name)
  end

  if #servers > 0 then
    return "   " .. table.concat(servers, ", ")
  end

  return ""
end

M.get_mode = function()
  if not is_current() then
    return "%#StatusLineInactive# " .. vim.fn.winnr() .. " %*"
  end
  local mode_code = vim.api.nvim_get_mode().mode
  local mode = mode_map[mode_code] or string.upper(mode_code)
  return mode
end

M.get_mode_colors = function(mode)
  return {
    a = "%#StatusLine" .. mode:sub(1, 1) .. "1#",
    b = "%#StatusLine" .. mode:sub(1, 1) .. "2#",
    c = "%#StatusLineN3#",
    inactive = "%#StatusLineInactive#",
  }
end

--- @param mode string
M.get_mode_part = function(mode)
  if vim.fn.strdisplaywidth(mode) > 1 then
    return mode
  end

  local mode_colors = M.get_mode_colors(mode)
  return M.paint(" " .. (mode_icons[mode] or mode) .. " ", mode_colors["a"])
end

M.paint = function(text, color)
  if text == "" then
    return ""
  end

  return color .. text .. "%*"
end

_G.status = M
vim.o.winbar = "%{%v:lua.status.get_winbar()%}"
vim.o.statusline = "%{%v:lua.status.get_status_line()%}"

-- fix statusline diappears when enter insert mode
utils.autocmd("InsertEnter", { command = ":let &stl=&stl" })

return M
