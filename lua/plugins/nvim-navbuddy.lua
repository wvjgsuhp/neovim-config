local constants = require("constants")

return {
  "SmiteshP/nvim-navbuddy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    window = {
      border = "single", -- "rounded", "double", "solid", "none"
      -- or an array with eight chars building up the border in a clockwise fashion
      -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
      size = "62%", -- Or table format example: { height = "40%", width = "100%"}
      position = "50%", -- Or table format example: { row = "100%", col = "0%"}
      scrolloff = nil, -- scrolloff value within navbuddy window
      sections = {
        left = {
          size = "20%",
          border = nil, -- You can set border style for each section individually as well.
        },
        mid = {
          size = "40%",
          border = nil,
        },
        right = {
          -- No size option for right most section. It fills to
          -- remaining area.
          border = nil,
          preview = "leaf", -- Right section can show previews too.
          -- Options: "leaf", "always" or "never"
        },
      },
    },
    icons = constants.icons,
    lsp = {
      auto_attach = true, -- If set to true, you don't need to manually use attach function
      preference = nil, -- list of lsp server names in order of preference
    },
  },
  keys = {
    { "<Leader>fn", "<cmd>Navbuddy<cr>" },
  },
}
