local utils = require("utils")

return {
  "folke/lsp-colors.nvim",
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",

  -- commands

  "tpope/vim-repeat",
  "tpope/vim-surround",
  {
    "nullchilly/fsread.nvim",
    keys = {
      { "<Leader>br", "<cmd>FSToggle<CR>" },
    },
  },
  {
    "mzlogin/vim-markdown-toc",
    config = function()
      vim.g.vmt_auto_update_on_save = 0
    end,
    ft = { "md" },
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({ window = { border = "single" } })
      utils.noremap("n", "<Leader>k", "<cmd>WhichKey<cr>")
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    cond = vim.g.is_unix == 1,
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },

  -- interface

  "MunifTanjim/nui.nvim",
  "lilydjwg/colorizer",
  "romainl/vim-cool",
  {
    "rhysd/clever-f.vim",
    config = function()
      vim.g.clever_f_mark_direct = 1
    end,
  },
  {
    "rhysd/accelerated-jk",
    keys = {
      { "j", "<Plug>(accelerated_jk_gj)zz" },
      { "k", "<Plug>(accelerated_jk_gk)zz" },
    },
  },

  -- completion and code analysis

  "folke/neodev.nvim",
  {
    "folke/trouble.nvim",
    keys = {
      { "<Leader>dd", "<cmd>Trouble document_diagnostics<cr>", desc = "Diagnose the current buffer" },
      { "<Leader>dw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Diagnose the current workspace" },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "single",
        icons = {
          package_installed = " ",
          package_pending = " ",
          package_uninstalled = " ",
        },
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- - repo: mattn/emmet-vim
  --   on_event: InsertEnter
  --   on_ft: [html, css, vue, javascript, javascriptreact, svelte]
  --   hook_source: |-
  --     let g:user_emmet_mode = 'i'
  --     let g:user_emmet_install_global = 0
  --     let g:user_emmet_install_command = 0
  --     let g:user_emmet_complete_tag = 0

  -- syntax

  "tpope/vim-sleuth",

  -- Vimscript syntax/indent plugins

  { "chrisbra/csv.vim", ft = { "csv" } },
  -- - { repo: MTDL9/vim-log-highlighting, on_ft: log }

  -- - repo: preservim/vim-markdown
  --   on_ft: markdown
  --   hook_add: |-
  --     let g:vim_markdown_frontmatter = 1
  --     let g:vim_markdown_strikethrough = 1
  --     let g:vim_markdown_folding_disabled = 1
  --     let g:vim_markdown_conceal = 1
  --     let g:vim_markdown_conceal_code_blocks = 1
  --     let g:vim_markdown_new_list_item_indent = 0
  --     let g:vim_markdown_toc_autofit = 0
  --     let g:vim_markdown_follow_anchor = 0
  --     let g:vim_markdown_no_extensions_in_markdown = 1
  --     let g:vim_markdown_edit_url_in = 'vsplit'
  --     let g:vim_markdown_fenced_languages = [
  --       \ 'c++=cpp',
  --       \ 'viml=vim',
  --       \ 'bash=sh',
  --       \ 'ini=dosini',
  --       \ 'js=javascript',
  --       \ 'json=javascript',
  --       \ 'jsx=javascriptreact',
  --       \ 'tsx=typescriptreact',
  --       \ 'docker=Dockerfile',
  --       \ 'makefile=make',
  --       \ 'py=python'
  --       \ ]

  -- operators and text objects
  {
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup()
    end,
    keys = {
      { "<Leader>fw", "<cmd>HopWord<cr>", mode = { "n", "v", "o" }, desc = "Jump to a word" },
      { "<Leader>fa", "<cmd>HopAnywhere<cr>", mode = { "n", "v", "o" }, desc = "Jump anywhere" },
      { "<Leader>fl", "<cmd>HopLine<cr>", mode = { "n", "v", "o" }, desc = "Jump to a line" },
      { "<Leader>fc", "<cmd>HopChar1<cr>", mode = { "n", "v", "o" }, desc = "Jump to a character" },
    },
  },

  -- buffer

  { "chrisgrieser/nvim-early-retirement", config = true },

  -- debug

  { "nvim-treesitter/playground", cmd = { "TSHighlightCapturesUnderCursor" } },
}
