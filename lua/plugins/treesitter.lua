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
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = { "r" },
      },

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
