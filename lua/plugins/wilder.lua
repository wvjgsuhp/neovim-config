return {
  "gelguy/wilder.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  enabled = false,
  config = function()
    local wilder = require("wilder")

    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
        highlights = {
          default = "WilderNormal",
          prompt = "WilderPrompt",
          border = "WilderBorder", -- highlight to use for the border

          -- matching highlight
          accent = wilder.make_hl(
            "WilderAccent",
            "Pmenu",
            { { a = 1 }, { a = 1 }, { foreground = "#0086B3" } }
          ),
        },
        border = { " ", " ", " ", " ", " ", " ", " ", " " },
        prompt_border = { " ", " ", " " },
        min_width = "68%",
        max_width = "68%",

        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },

        highlighter = wilder.basic_highlighter(),
      }))
    )

    wilder.setup({
      modes = { "/" },
      accept_key = "<C-y>",
    })
  end,
}
