return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "kevinhwang91/nvim-ufo",
  },
  build = ":TSUpdate",
  config = function()
    local languages = {
      "bash",
      "c",
      "css",
      "dockerfile",
      "dot",
      "html",
      "java",
      "javascript",
      "json",
      "json5",
      "lua",
      "markdown",
      "python",
      "r",
      "regex",
      "rust",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
    }
    require("nvim-treesitter").install(languages)

    local highlights = vim.list_extend(languages, { "typescriptreact", "javascriptreact", "sh" })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = highlights,
      callback = function()
        vim.treesitter.start()
      end,
    })
    -- Setup treesitter
    -- require("nvim-treesitter.configs").setup({
    --   -- all, maintained, or list of languages
    --   highlight = {
    --     enable = true,
    --     -- disable = { "vim" },
    --     disable = function(lang, buf)
    --       local max_filesize = 100 * 1024 -- 100 KB
    --       local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --       if ok and stats and stats.size > max_filesize then
    --         return true
    --       end
    --     end,
    --     additional_vim_regex_highlighting = { "r" },
    --   },
    --
    --   indent = {
    --     enable = true,
    --   },
    --
    --   refactor = {
    --     highlight_definitions = { enable = true },
    --     highlight_current_scope = { enable = true },
    --   },
    --
    --
    --   -- See: https://github.com/windwp/nvim-ts-autotag
    --   autotag = {
    --     enable = true,
    --     filetypes = {
    --       "html",
    --       "javascript",
    --       "javascriptreact",
    --       "svelte",
    --       "typescriptreact",
    --       "vue",
    --       "markdown",
    --     },
    --   },
    -- })
  end,
}
