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
      },

      highlight = {
        enable = true,
        disable = { "vim" },
      },

      additional_vim_regex_highlighting = false,

      indent = {
        enable = true,
      },

      refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = true },
      },

      -- See: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },

      -- See: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
      context_commentstring = {
        enable = true,
        -- Let other plugins (kommentary) call 'update_commentstring()' manually.
        enable_autocmd = false,
      },

      -- See: https://github.com/windwp/nvim-ts-autotag
      autotag = {
        enable = true,
        filetypes = {
          "html",
          "javascript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
        },
      },
    })
  end,
}
