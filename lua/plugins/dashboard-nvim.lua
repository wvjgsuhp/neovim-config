return {
  "nvimdev/dashboard-nvim",
  lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
  config = function()
    local constants = require("constants")
    local utils = require("utils")
    local width = 31
    local logo = vim.list_extend({ "", "", "", "", "", "", "", "" }, constants.logo.neovim_04)
    logo = vim.list_extend(logo, { "", "", "" })

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
      },
      config = {
        header = logo,
          -- stylua: ignore
        center = {
          { action = "Telescope find_files",          desc = " Find files",       icon = "󰍉 ", key = "<Leader>ff" },
          { action = "Telescope grep_string search=", desc = " Fuzzy-find words", icon = "󰒻 ", key = "<Leader>fg" },
          { action = "Neotree float",                 desc = " Explore",          icon = " ", key = "e" },
          { action = "Telescope live_grep",           desc = " Find words",       icon = " ", key = "f" },
          { action = "SessionRestore",                desc = " Restore session",  icon = "󰦛 ", key = "r" },
          { action = "WhichKey",                      desc = " Open key maps",    icon = "󰥻 ", key = "w" },
          { action = "Lazy",                          desc = " Lazy",             icon = "󰒲 ", key = "z" },
          { action = "qa",                            desc = " Quit",             icon = "󰩈 ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local plugin_count = tostring(stats.count)
          local ms = tostring(math.floor((stats.startuptime * 100 + 0.5) / 100))
          local stats_padding = "%-" .. math.max(#plugin_count, #ms) + 1 .. "s"

          local plugins = "  " .. string.format(stats_padding, stats.count) .. "plugins"
          local startup_time = "󰦖  " .. string.format(stats_padding, ms) .. "ms"
          local footer_width_diff = vim.fn.strdisplaywidth(plugins) - vim.fn.strdisplaywidth(startup_time)

          if footer_width_diff > 0 then
            startup_time = startup_time .. string.rep(" ", footer_width_diff)
          elseif footer_width_diff < 0 then
            plugins = plugins .. string.rep(" ", footer_width_diff)
          end

          return { plugins, startup_time }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", width - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      utils.autocmd("User", {
        pattern = "DashboardLoaded",
        callback = require("lazy").show,
      })
    end

    utils.autocmd_filetype(
      "dashboard",
      vim.schedule_wrap(function()
        vim.opt_local.foldenable = false
      end)
    )

    require("dashboard").setup(opts)
  end,
}
