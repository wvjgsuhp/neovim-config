local constants = require("constants")
return {
  "goolord/alpha-nvim",
  config = function()
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
          hl = "Identifier",
          hl_shortcut = "String",
        },
      }
    end

    dashboard.section.header.val = constants.alpha.header.portal_01
    dashboard.section.header.opts.hl = "Normal"

    dashboard.section.buttons.val = {
      create_alpha_button("<Leader>ff", "󰍉 Find files"),
      create_alpha_button("<Leader>e", " Explore"),
      create_alpha_button("r", "󰦛 Restore session", "<Cmd>SessionRestore<CR>"),
      create_alpha_button("w", "󰥻 WhichKey", "<Cmd>WhichKey<CR>"),
      create_alpha_button("z", "󰒲 Lazy", "<Cmd>Lazy<CR>"),
      create_alpha_button("q", "󰩈 Quit", "<Cmd>qa<CR>"),
    }

    -- footer
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
        local footer = "  " .. stats.count .. " plugins lazy-loaded in " .. ms .. " ms  "

        dashboard.section.footer.val = footer
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    dashboard.config.layout[1].val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) })
    dashboard.config.layout[3].val = 3
    dashboard.config.opts.noautocmd = true

    require("alpha").setup(dashboard.config)
  end,
}
