-- https://www.reddit.com/r/neovim/comments/vpxexc/pde_custom_winbar_and_statusline_without_plugins/
local M = {}
local utils = require("utils")

local is_current = function()
  local winid = vim.g.actual_curwin
  if utils.isempty(winid) then
    return false
  else
    return winid == tostring(vim.api.nvim_get_current_win())
  end
end

-- local winbar_filetype_exclude = {
--   [""] = true,
-- }

M.get_winbar = function()
  -- floating window
  local cfg = vim.api.nvim_win_get_config(0)
  if cfg.relative > "" or cfg.external then
    return ""
  end

  local mode_part = M.get_mode_part()

  local buftype = vim.bo.buftype
  if buftype == "terminal" then
    return table.concat({
      mode_part,
      M.get_icon(),
      " TERMINAL-%n %#WinBarLocation# %{b:term_title}%*",
    })
  elseif buftype == "nofile" then
    return table.concat({
      mode_part,
      M.get_icon(),
      " " .. vim.bo.filetype,
    })
  -- elseif winbar_filetype_exclude[vim.bo.filetype] then
  --   return M.active_indicator()
  else
    -- real files do not have buftypes
    if utils.isempty(buftype) then
      return table.concat({
        mode_part,
        M.get_filename(),
        "%<",
        M.get_location(),
      })
    else
      -- Meant for quickfix, help, etc
      return mode_part .. "%( %h%) %f"
    end
  end
end

M.get_statusline = function()
  local mode = M.get_mode()
  local mode_color = M.get_mode_colors(mode)

  local relative_path = M.get_relative_path()
  local lines_columns = " %3l/%L󰉸 %3c󰤼 %*"

  if is_current() then
    local parts = {
      -- left
      mode_color["a"],
      M.get_git_branch(),
      mode_color["b"],
      M.get_recording(),

      -- middle-left
      "%<",
      mode_color["c"],
      relative_path,
      M.get_git_changes(),
      M.get_diags(),

      -- middle-right
      "%=",
      mode_color["c"],
      M.get_language_servers(),
      " ",

      -- right
      mode_color["b"],
      os.date(" %H:%M "),
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

-- M.active_indicator = function()
--   if is_current() then
--     return "%#WinBarIndicator#▔▔▔▔▔▔▔▔%*"
--   else
--     return ""
--   end
-- end

-- stylua: ignore
local cache_icons = {
  -- custom icons here
  NvimTree  = "",
  terminal  = "",
  Trouble   = "",
  r         = "󰟔 ",
}

M.get_icon = function()
  local buftype = vim.bo.buftype
  local filetype = vim.bo.filetype

  if utils.isempty(buftype) then
    if vim.bo.modified then
      return " %#WinBarModified# %*"
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

  local default_icon_hl = " %#WinBarIcon#"
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
local diagnostic_signs = {
  Error = "󰅙 ",
  Warn = "󱇎 ",
  Info = " ",
  Hint = "󰌵 ",
}

local get_sign = function(severity)
  local hl = "%#StatusLine" .. severity .. "#"
  return hl .. diagnostic_signs[severity]
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

  local result = " "
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
    return "  " .. branch .. " "
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
        local hl = " %#StatusLineGit" .. utils.capitalize(change) .. "#"
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
      return "%#WinBarLocation# " .. location .. "%*"
    else
      return ""
    end
  end)

  if not success then
    return ""
  end
  return result
end

M.get_recording = function()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return " recording @" .. recording_register .. " "
  end
end

M.get_relative_path = function()
  if vim.bo.buftype == "terminal" then
    return " terminal"
  elseif vim.bo.buftype == "nofile" then
    return " " .. vim.bo.filetype
  end

  local file = " %f"

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
    return "   " .. table.concat(servers, ", ")
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

M.get_mode_part = function()
  local mode = M.get_mode()
  if mode:len() > 1 then
    return mode
  end

  local mode_colors = M.get_mode_colors(mode)
  return M.paint(" " .. mode .. " ", mode_colors["a"])
end

M.paint = function(text, color)
  if text == "" then
    return ""
  end

  return color .. text .. "%*"
end

_G.status = M
vim.o.winbar = "%{%v:lua.status.get_winbar()%}"
vim.o.statusline = "%{%v:lua.status.get_statusline()%}"

-- fix statusline diappears when enter insert mode
vim.api.nvim_create_autocmd("InsertEnter", { command = ":let &stl=&stl" })

return M
