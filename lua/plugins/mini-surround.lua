return {
  "echasnovski/mini.surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  opts = {
    -- Add custom surroundings to be used on top of builtin ones. For more
    -- information with examples, see `:h MiniSurround.config`.
    custom_surroundings = nil,

    -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
    highlight_duration = 500,

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      add = "Sa", -- Add surrounding in Normal and Visual modes
      delete = "Sd", -- Delete surrounding
      find = "Sf", -- Find surrounding (to the right)
      find_left = "SF", -- Find surrounding (to the left)
      highlight = "Sh", -- Highlight surrounding
      replace = "Sr", -- Replace surrounding
      update_n_lines = "Sn", -- Update `n_lines`

      suffix_last = "l", -- Suffix to search with "prev" method
      suffix_next = "n", -- Suffix to search with "next" method
    },

    -- Number of lines within which surrounding is searched
    n_lines = 20,
  },
}
