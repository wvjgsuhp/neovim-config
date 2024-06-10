return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "kevinhwang91/nvim-ufo",
  },
  build = ":TSUpdate",
  config = function()
    -- Setup treesitter
    require("nvim-treesitter.configs").setup({
      -- all, maintained, or list of languages
      ensure_installed = {
        "bash",
        "c",
        "css",
        "dockerfile",
        "dot",
        "fish",
        "html",
        "java",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "lua",
        "markdown",
        "python",
        "regex",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
      },

      highlight = {
        enable = true,
        -- disable = { "vim" },
      },

      additional_vim_regex_highlighting = false,

      indent = {
        enable = true,
      },

      refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = true },
      },

      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]fs"] = "@function.outer", ["]cs"] = "@class.outer" },
          goto_next_end = { ["]fe"] = "@function.outer", ["]ce"] = "@class.outer" },
          goto_previous_start = { ["]Fs"] = "@function.outer", ["]Cs"] = "@class.outer" },
          goto_previous_end = { ["]Fe"] = "@function.outer", ["]Ce"] = "@class.outer" },
        },
      },

      -- See: https://github.com/windwp/nvim-ts-autotag
      autotag = {
        enable = true,
        filetypes = {
          "html",
          "javascript",
          "javascriptreact",
          "svelte",
          "typescriptreact",
          "vue",
          "markdown",
        },
      },
    })
  end,
}
