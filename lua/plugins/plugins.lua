return {
  "nvim-tree/nvim-web-devicons",

  -- commands
  {
    "nullchilly/fsread.nvim",
    keys = {
      { "<Leader>br", "<cmd>FSToggle<CR>" },
    },
  },
  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown" },
  },
  {
    "folke/which-key.nvim",
    opts = {},
    cmd = "WhichKey",
    keys = {
      { "<Leader>k", "<cmd>WhichKey<CR>" },
    },
  },

  -- interface
  "MunifTanjim/nui.nvim",
  {
    "folke/zen-mode.nvim",
    opts = {},
    keys = {
      { "<Leader>zm", "<cmd>ZenMode<CR>" },
    },
  },
  {
    "voldikss/vim-floaterm",
    config = function()
      vim.g.floaterm_title = " $1/$2"
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_height = math.min(55 / vim.o.lines, 0.6)
      vim.g.floaterm_borderchars = "        "
      vim.g.floaterm_autoinsert = false
      vim.g.floaterm_titleposition = "center"
    end,
    keys = {
      { "<Leader>`", "<cmd>FloatermToggle<CR>" },
      { "<Leader>zn", "<cmd>FloatermNew<CR>" },
    },
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    opts = {
      italic_comments = false,
      hide_fillchars = true,
      borderless_telescope = true,
      terminal_colors = true,
    },
  },
  {
    "wvjgsuhp/nvim-github-theme",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "lukas-reineke/headlines.nvim",
    opts = {},
    ft = { "markdown", "rmd" },
  },

  -- coding
  {
    "folke/lazydev.nvim",
    opts = {},
    ft = "lua",
  },
  {
    "folke/trouble.nvim",
    opts = {},
    keys = {
      { "<Leader>dd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagn current buffer" },
      { "<Leader>dw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diag current workspace" },
    },
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<Leader>ft", "<cmd>TodoTelescope<CR>", desc = "Fuzzy find todo comments" },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    version = "1.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      vim.tbl_map(function(type)
        require("luasnip.loaders.from_" .. type).lazy_load()
      end, { "vscode", "snipmate", "lua" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    enabled = false,
    lazy = true,
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    config = function()
      require("mason").setup()
      require("mason-nvim-dap").setup({
        automatic_installation = true,
      })
    end,
  },
  {
    "andythigpen/nvim-coverage",
    config = function()
      require("coverage").setup({
        commands = true,
        signs = {
          covered = { hl = "GitSignsAdd", text = "▌" },
          uncovered = { hl = "GitSignsDelete", text = "▌" },
        },
      })
    end,
    cmd = { "Coverage", "CoverageLoad", "CoverageToggle" },
    keys = {
      { "<Leader>ct", "<cmd>CoverageToggle<CR>", desc = "Toggle coverage" },
      { "<Leader>cs", "<cmd>Coverage<CR>", desc = "Update coverage" },
    },
  },
  -- {
  --   "mfussenegger/nvim-dap-python",
  --   config = function()
  --     require("dap-python").setup("~/.venv/debugpy/bin/python")
  --   end,
  -- },
  -- - repo: mattn/emmet-vim
  --   on_event: InsertEnter
  --   on_ft: [html, css, vue, javascript, javascriptreact, svelte]
  --   hook_source: |-
  --     let g:user_emmet_mode = 'i'
  --     let g:user_emmet_install_global = 0
  --     let g:user_emmet_install_command = 0
  --     let g:user_emmet_complete_tag = 0

  -- syntax/indent plugins
  {
    "NMAC427/guess-indent.nvim",
    opts = {},
  },
  {
    "jalvesaq/Nvim-R",
    config = function()
      vim.g.R_assign = 0
      vim.g.R_nvim_wd = 0
    end,
    ft = { "r" },
  },
  {
    "chrisbra/csv.vim",
    config = function()
      vim.g.no_csv_maps = 1
      vim.g.csv_arrange_align = "l*"
      vim.cmd([[
      augroup csv_plugin
        autocmd!
        autocmd FileType csv nnoremap <buffer> <Leader>aa ggVG:'<,'>ArrangeColumn<cr>
        autocmd FileType csv nnoremap <buffer> <Leader>au ggVG:'<,'>UnArrangeColumn<cr>
      augroup END
    ]])
    end,
    ft = { "csv" },
  },
  -- - { repo: MTDL9/vim-log-highlighting, on_ft: log }

  -- operators and text objects

  -- buffer
  {
    "chrisgrieser/nvim-early-retirement",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- debug

  { "nvim-treesitter/playground", cmd = { "TSHighlightCapturesUnderCursor" } },
}
