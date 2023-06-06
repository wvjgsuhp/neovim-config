local constants = require("constants")
return {
  "goolord/alpha-nvim",
  config = function()
    local dashboard = require("alpha.themes.dashboard")

    local create_alpha_button = function(shortcut, text)
      local shortcut_text = shortcut
      local mapping = shortcut:gsub("%s", "")

      -- if the leader is set, replace the text with the actual leader key for nicer printing
      if vim.g.mapleader then
        shortcut_text = shortcut:gsub("<Leader>", vim.g.mapleader == " " and "<space>" or vim.g.mapleader)
      end

      return {
        type = "button",
        val = text,
        on_press = function()
          local key = vim.api.nvim_replace_termcodes(mapping, true, false, true)
          vim.api.nvim_feedkeys(key, "normal", false)
        end,
        opts = {
          position = "center",
          text = text,
          shortcut = shortcut_text,
          cursor = 5,
          width = 36,
          align_shortcut = "right",
          hl = "DashboardCenter",
          hl_shortcut = "DashboardShortcut",
        },
      }
    end

    dashboard.section.header.val = constants.alpha.header.blood_01
    dashboard.section.header.opts.hl = "DashboardHeader"

    dashboard.section.buttons.val = {
      create_alpha_button("<Leader>sr", "󰦛 Restore session"),
      create_alpha_button("<Leader>ff", "󰍉 Find files"),
      create_alpha_button("<Leader>e", " Explore"),
    }

    dashboard.config.layout[1].val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) })
    dashboard.config.layout[3].val = 5
    dashboard.config.opts.noautocmd = true

    require("alpha").setup(dashboard.config)
  end,
}
