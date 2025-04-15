return {
  "goolord/alpha-nvim",
  enabled = false,
  event = "VimEnter",
  config = function()
    local constants = require("constants")
    local utils = require("utils")
    local dashboard = require("alpha.themes.dashboard")

    local create_alpha_button = function(shortcut, text, pressing_keys)
      local shortcut_text = shortcut
      if pressing_keys == nil then
        pressing_keys = shortcut:gsub("%s", "")
      else
        vim.api.nvim_buf_set_keymap(0, "n", shortcut, pressing_keys, {})
      end

      -- if the leader is set, replace the text with the actual leader key for nicer printing
      if vim.g.mapleader then
        shortcut_text = shortcut:gsub("<Leader>", vim.g.mapleader == " " and "<space>" or vim.g.mapleader)
      end

      return {
        type = "button",
        val = text,
        on_press = function()
          local key = vim.api.nvim_replace_termcodes(pressing_keys, true, false, true)
          vim.api.nvim_feedkeys(key, "normal", false)
        end,
        opts = {
          position = "center",
          text = text,
          shortcut = shortcut_text,
          cursor = 5,
          width = 36,
          align_shortcut = "right",
          hl = "DashboardText",
          hl_shortcut = "String",
        },
      }
    end

    dashboard.section.header.val = constants.alpha.header.neovim_04
    dashboard.section.header.opts.hl = "DashboardHeader"

    dashboard.section.buttons.val = {
      create_alpha_button("<Leader>ff", "󰍉 Find files"),
      create_alpha_button("<Leader>fg", "󰒻 Fuzzy-find words"),
      create_alpha_button("n", " New file", ":e "),
      create_alpha_button("e", " Explore", "<Leader>e"),
      create_alpha_button("f", " Find words", "<Leader>fm"),
      create_alpha_button("r", "󰦛 Restore session", "<Cmd>SessionRestore<CR>"),
      create_alpha_button("w", "󰥻 WhichKey", "<Cmd>WhichKey<CR>"),
      create_alpha_button("z", "󰒲 Lazy", "<Cmd>Lazy<CR>"),
      create_alpha_button("q", "󰩈 Quit", "<Cmd>qa<CR>"),
    }

    -- footer
    utils.autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local plugin_count = tostring(stats.count)
        local ms = tostring(math.floor((stats.startuptime * 100 + 0.5) / 100))
        local stats_padding = "%-" .. math.max(#plugin_count, #ms) + 1 .. "s"

        local footer = {
          "  " .. string.format(stats_padding, stats.count) .. "plugins",
          "󰦖  " .. string.format(stats_padding, ms) .. "ms",
        }

        dashboard.section.footer.val = footer
        dashboard.section.footer.opts.hl = "Comment"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    dashboard.config.opts.noautocmd = true

    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      utils.autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.config)
  end,
}
