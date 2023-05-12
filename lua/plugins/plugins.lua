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
  "nullchilly/fsread.nvim",
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
  },

  -- interface
  "MunifTanjim/nui.nvim",
  "lilydjwg/colorizer",
  -- - { repo: romainl/vim-cool, on_event: [CursorMoved, InsertEnter] }
  -- - { repo: haya14busa/vim-asterisk, on_map: { nv: <Plug> } }
  {
    "rhysd/accelerated-jk",
    config = function()
      utils.noremap("n", "j", "<Plug>(accelerated_jk_gj)zz")
      utils.noremap("n", "k", "<Plug>(accelerated_jk_gk)zz")
    end,
  },
  -- - { repo: t9md/vim-quickhl, on_map: { nx: <Plug> } }

  -- - repo: deris/vim-shot-f
  --   on_map: { nxo: <Plug> }
  --   hook_add: let g:shot_f_no_default_key_mappings = 1

  -- completion and code analysis

  "folke/neodev.nvim",

  -- - repo: ray-x/lsp_signature.nvim
  --   if: has('nvim-0.6.1')
  --   on_source: nvim-lspconfig

  -- - repo: hrsh7th/vim-vsnip
  --   on_event: InsertEnter
  --   merged: 0
  --   hook_add: |-
  --     let g:vsnip_snippet_dir = expand('$VIM_DATA_PATH/vsnip')
  --     let g:vsnip_snippet_dirs = [ expand('$VIM_PATH/snippets') ]
  --     let g:vsnip_filetypes = {}
  --     let g:vsnip_filetypes.javascriptreact = ['javascript']
  --     let g:vsnip_filetypes.typescriptreact = ['typescript']

  -- - { repo: hrsh7th/vim-vsnip-integ, on_source: vim-vsnip }
  -- - { repo: rafamadriz/friendly-snippets, merged: 0, on_source: vim-vsnip }

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- - repo: folke/todo-comments.nvim
  --   if: has('nvim-0.5')
  --   on_source: [telescope.nvim, neovim/nvim-lspconfig]
  --   hook_post_source: lua require('plugins.todo-comments')

  "folke/trouble.nvim",

  {
    "sindrets/diffview.nvim",
    config = function()
      utils.noremap("n", "<Leader>gdo", "<cmd>DiffviewOpen<cr>")
      utils.noremap("n", "<Leader>gds", "<cmd>Gvdiffsplit!<cr>")
    end,
  },
  --   if: has('nvim-0.5')
  --   on_cmd: [DiffviewOpen, DiffviewFileHistory]
  --   hook_post_source: lua require('plugins.diffview').setup()

  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },

  -- - repo: nvim-telescope/telescope-fzf-native.nvim
  --   build: cmake
  --   on_source: telescope.nvim
  --   hook_post_source: lua require('telescope').load_extension('fzf')

  -- - repo: mattn/emmet-vim
  --   on_event: InsertEnter
  --   on_ft: [html, css, vue, javascript, javascriptreact, svelte]
  --   hook_source: |-
  --     let g:user_emmet_mode = 'i'
  --     let g:user_emmet_install_global = 0
  --     let g:user_emmet_install_command = 0
  --     let g:user_emmet_complete_tag = 0

  -- syntax
  --

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

  "tpope/vim-sleuth",

  -- operators and text objects
  {
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup()

      utils.noremap("n", "<Leader>fw", "<cmd>HopWord<cr>")
      utils.noremap("n", "<Leader>fa", "<cmd>HopAnywhere<cr>")
      utils.noremap("n", "<Leader>fl", "<cmd>HopLine<cr>")
      utils.noremap("n", "<Leader>fc", "<cmd>HopChar1<cr>")
    end,
  },

  -- buffer

  { "chrisgrieser/nvim-early-retirement", config = true },
}
