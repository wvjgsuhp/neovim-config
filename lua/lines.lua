-- https://www.reddit.com/r/neovim/comments/vpxexc/pde_custom_winbar_and_statusline_without_plugins/
local M = {}

local isempty = function(s)
  return s == nil or s == ""
end

local is_current = function()
  local winid = vim.g.actual_curwin
  if isempty(winid) then
    return false
  else
    return winid == tostring(vim.api.nvim_get_current_win())
  end
end

-- stylua: ignore
local winbar_filetype_exclude = {
  [""]              = true,
  ["NvimTree"]      = true,
  ["Outline"]       = true,
  ["Trouble"]       = true,
  ["alpha"]         = true,
  ["dashboard"]     = true,
  ["lir"]           = true,
  ["neo-tree"]      = true,
  ["neogitstatus"]  = true,
  ["packer"]        = true,
  ["spectre_panel"] = true,
  ["startify"]      = true,
  ["toggleterm"]    = true,
}

M.get_winbar = function()
  -- floating window
  local cfg = vim.api.nvim_win_get_config(0)
  if cfg.relative > "" or cfg.external then
    return ""
  end

  local mode_part = M.get_mode_part()

  if vim.bo.buftype == "terminal" then
    return table.concat({
      mode_part,
      M.get_icon(),
      "TERMINAL #%n %#WinBarLocation# %{b:term_title}%*",
    })
  elseif vim.bo.buftype == "nofile" then
    return table.concat({
      mode_part,
      -- M.get_icon(),
      " ",
      vim.bo.filetype,
    })
  elseif winbar_filetype_exclude[vim.bo.filetype] then
    return M.active_indicator()
  else
    -- real files do not have buftypes
    if isempty(vim.bo.buftype) then
      return table.concat({
        mode_part,
        M.get_filename(),
        "%<",
        M.get_location(),
        "%=",
        M.get_diag(),
        M.get_git_dirty(),
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

  local relative_path_part = M.get_relative_path_part()
  local lines_columns = " %3l/%L󰉸 %3c󰤼 %*"

  if is_current() then
    local parts = {
      -- left
      mode_color["a"],
      M.get_git_branch(),
      mode_color["b"],
      M.get_recording(),

      -- middle
      mode_color["c"],
      "%<",
      relative_path_part,

      -- right
      "%=",
      M.get_diag_counts(),
      M.get_git_changes(),
      mode_color["b"],
      os.date(" %H:%M "),
      mode_color["a"],
      lines_columns,
    }
    return table.concat(parts)
  else
    local parts = {
      mode_color["inactive"],
      "%<",
      relative_path_part,
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

M.active_indicator = function()
  if is_current() then
    return "%#WinBarIndicator#▔▔▔▔▔▔▔▔%*"
  else
    return ""
  end
end
local icon_cache = {}

M.get_icon = function(filename, extension)
  if not filename then
    if vim.bo.modified then
      return " %#WinBarModified# %*"
    end

    if vim.bo.buftype == "terminal" then
      filename = "terminal"
      extension = "terminal"
    else
      filename = vim.fn.expand("%:t")
    end
  end

  local cached = icon_cache[filename]
  if not cached then
    if not extension then
      extension = vim.fn.fnamemodify(filename, ":e")
    end
    local file_icon, hl_group = require("nvim-web-devicons").get_icon(filename, extension)
    cached = " " .. "%#" .. hl_group .. "#" .. file_icon .. " %*"
    icon_cache[filename] = cached
  end
  return cached
end

M.get_filename = function()
  local has_icon, icon = pcall(M.get_icon)
  if has_icon then
    return icon .. "%t"
  else
    return " %t"
  end
end

local make_two_char = function(symbol)
  if symbol:len() == 1 then
    return symbol .. " "
  else
    return symbol
  end
end

local sign_cache = {}
local get_sign = function(severity, icon_only)
  if icon_only then
    local defined = vim.fn.sign_getdefined("DiagnosticSign" .. severity)
    if defined and defined[1] then
      return " " .. defined[1].text
    else
      return " " .. severity[1]
    end
  end

  local cached = sign_cache[severity]
  if cached then
    return cached
  end

  local defined = vim.fn.sign_getdefined("DiagnosticSign" .. severity)
  local text, highlight
  defined = defined and defined[1]
  if defined and defined.text and defined.texthl then
    text = " " .. make_two_char(defined.text)
    highlight = defined.texthl
  else
    text = " " .. severity:sub(1, 1)
    highlight = "Diagnostic" .. severity
  end
  cached = "%#" .. highlight .. "#" .. text .. "%*"
  sign_cache[severity] = cached
  return cached
end

M.get_diag = function()
  local d = vim.diagnostic.get(0)
  if #d == 0 then
    return ""
  end

  local min_severity = 100
  for _, diag in ipairs(d) do
    if diag.severity < min_severity then
      min_severity = diag.severity
    end
  end
  local severity = ""
  if min_severity == vim.diagnostic.severity.ERROR then
    severity = "Error"
  elseif min_severity == vim.diagnostic.severity.WARN then
    severity = "Warn"
  elseif min_severity == vim.diagnostic.severity.INFO then
    severity = "Info"
  elseif min_severity == vim.diagnostic.severity.HINT then
    severity = "Hint"
  else
    return ""
  end

  return get_sign(severity)
end

M.get_diag_counts = function()
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
  if grouped[severity.ERROR] then
    result = result .. "%#StatusLineError#" .. grouped[severity.ERROR] .. get_sign("Error", true)
  end
  if grouped[severity.WARN] then
    result = result .. "%#StatusLineWarn#" .. grouped[severity.WARN] .. get_sign("Warn", true)
  end
  if grouped[severity.INFO] then
    result = result .. "%#StatusLineInfo#" .. grouped[severity.INFO] .. get_sign("Info", true)
  end
  if grouped[severity.HINT] then
    result = result .. "%#StatusLineHint#" .. grouped[severity.HINT] .. get_sign("Hint", true)
  end
  return result
end

M.get_git_branch = function()
  local branch = vim.fn.FugitiveStatusline():sub(6, -3)
  if isempty(branch) then
    return ""
  else
    return "  " .. branch .. " "
  end
end

M.get_git_changes = function()
  local changes = vim.b.gitsigns_status
  if isempty(changes) then
    return ""
  else
    return "%#StatusLineChanges#" .. changes .. " %*"
  end
end

M.get_git_dirty = function()
  local dirty = vim.b.gitsigns_status
  if isempty(dirty) then
    return " "
  else
    return "%#WinBarGitDirty# %*"
  end
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
    if not isempty(location) and location ~= "error" then
      return "%#WinBarLocation#  " .. location .. "%*"
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

M.get_relative_path_part = function()
  return " %f %{IsBuffersModified()}"
end

M.get_mode = function()
  if not is_current() then
    --return "%#WinBarInactive# win #" .. vim.fn.winnr() .. " %*"
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
  if string.len(mode) > 1 then
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

vim.cmd([[
  " [+] if only current modified, [+3] if 3 modified including current buffer.
  " [3] if 3 modified and current not, "" if none modified.
  function! IsBuffersModified()
    let cnt = len(filter(getbufinfo(), 'v:val.changed == 1'))
    return cnt == 0 ? "" : ( &modified ? "[+". (cnt>1?cnt:"") ."]" : "[".cnt."]" )
  endfunction
]])

_G.status = M
vim.o.winbar = "%{%v:lua.status.get_winbar()%}"
vim.o.statusline = "%{%v:lua.status.get_statusline()%}"

-- fix statusline diappears when enter insert mode
vim.cmd([[
  autocmd InsertEnter * execute(':let &stl=&stl')
]])

return M
