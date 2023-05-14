local utils = require("utils")

return {
  "folke/lsp-colors.nvim",
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",

  -- commands
  -- - repo: tversteeg/registers.nvim
  --   on_map: { i: "<C-r>", nx: '"' }
  --   hook_source: let g:registers_window_border = 'rounded'

  "tpope/vim-repeat",
  "tpope/vim-surround",
  {
    "nullchilly/fsread.nvim",
    keys = {
      { "<Leader>br", "<cmd>FSToggle<CR>" },
    },
  },
  {
    "tpope/vim-fugitive",
    config = function()
      utils.noremap("n", "<Leader>gs", "<cmd>G status<CR>")
      utils.noremap("n", "<Leader>gp", "<cmd>G push<CR>")
      utils.map("n", "<Leader>gac", ":G commit -am ''<Left>")
      utils.noremap("n", "<Leader>gaa", "<cmd>G add .<CR>")
    end,
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
      require("which-key").setup({ window = { border = "rounded" } })
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
    "rhysd/accelerated-jk",
    keys = {
      { "j", "<Plug>(accelerated_jk_gj)zz" },
      { "k", "<Plug>(accelerated_jk_gk)zz" },
    },
  },

  -- - { repo: haya14busa/vim-asterisk, on_map: { nv: <Plug> } }
  -- - { repo: t9md/vim-quickhl, on_map: { nx: <Plug> } }

  -- - repo: deris/vim-shot-f
  --   on_map: { nxo: <Plug> }
  --   hook_add: let g:shot_f_no_default_key_mappings = 1

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
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- - { repo: rafamadriz/friendly-snippets, merged: 0, on_source: vim-vsnip }

  -- - repo: folke/todo-comments.nvim
  --   if: has('nvim-0.5')
  --   on_source: [telescope.nvim, neovim/nvim-lspconfig]
  --   hook_post_source: lua require('plugins.todo-comments')

  --   if: has('nvim-0.5')
  --   on_cmd: [DiffviewOpen, DiffviewFileHistory]
  --   hook_post_source: lua require('plugins.diffview').setup()

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

  -- - repo: windwp/nvim-ts-autotag
  --   on_source: nvim-treesitter

  -- - repo: monkoose/matchparen.nvim
  --   if: has('nvim-0.7')
  --   on_event: FileType
  --   hook_post_source: lua require('matchparen').setup()

  -- Vimscript syntax/indent plugins

  -- - { repo: chrisbra/csv.vim, on_ft: csv }
  -- - { repo: vim-jp/syntax-vim-ex, on_ft: vim }
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
      { "<Leader>fw", "<cmd>HopWord<cr>", desc = "Jump to a word" },
      { "<Leader>fa", "<cmd>HopAnywhere<cr>", desc = "Jump anywhere" },
      { "<Leader>fl", "<cmd>HopLine<cr>", desc = "Jump to a line" },
      { "<Leader>fc", "<cmd>HopChar1<cr>", desc = "Jump to a character" },
    },
  },

  -- buffer

  { "chrisgrieser/nvim-early-retirement", config = true },
}
