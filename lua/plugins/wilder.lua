return {
  "gelguy/wilder.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    local wilder = require("wilder")

    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
        highlights = {
          border = "Normal", -- highlight to use for the border
        },
        border = "rounded",
        min_width = "68%",
        max_width = "68%",
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
        highlighter = wilder.basic_highlighter(),
      }))
    )
    wilder.setup({ modes = { ":", "/", "?" } })
  end,
}
