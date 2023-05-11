return {
  "folke/lsp-colors.nvim",
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",

  -- commands
  -- - repo: tversteeg/registers.nvim
  --   on_map: { i: "<C-r>", nx: '"' }
  --   hook_source: let g:registers_window_border = 'rounded'

'tpope/vim-repeat',
'tpope/vim-surround',
  {
    "mzlogin/vim-markdown-toc",
    config = function()
      vim.g.vmt_auto_update_on_save = 0
    end,
  },

  "nullchilly/fsread.nvim",
  "tpope/vim-fugitive",

  -- interface
  "MunifTanjim/nui.nvim",


  -- - { repo: romainl/vim-cool, on_event: [CursorMoved, InsertEnter] }
  -- - { repo: haya14busa/vim-asterisk, on_map: { nv: <Plug> } }
  "rhysd/accelerated-jk",
  -- - { repo: t9md/vim-quickhl, on_map: { nx: <Plug> } }

  -- - repo: itchyny/vim-cursorword
  --   on_event: FileType
  --   hook_add: let g:cursorword = 0
  --   hook_source: |-
  --     augroup user_plugin_cursorword
  --       autocmd!
  --       autocmd FileType json,yaml,markdown,nginx,dosini,conf,text
  --         \ let b:cursorword = 1
  --       autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif
  --       autocmd InsertEnter * if get(b:, 'cursorword', 0) == 1
  --         \| let b:cursorword = 0
  --         \| endif
  --       autocmd InsertLeave * if get(b:, 'cursorword', 1) == 0
  --         \| let b:cursorword = 1
  --         \| endif
  --     augroup END

  -- - repo: nathanaelkane/vim-indent-guides
  --   on_event: FileType
  --   hook_post_source: IndentGuidesEnable
  --   hook_source: |-
  --     let g:indent_guides_enable_on_vim_startup = 0
  --     let g:indent_guides_default_mapping = 0
  --     let g:indent_guides_tab_guides = 0
  --     let g:indent_guides_color_change_percent = 3
  --     let g:indent_guides_guide_size = 1
  --     let g:indent_guides_exclude_filetypes = [
  --       \ 'help', 'man', 'fern', 'defx', 'denite', 'denite-filter', 'startify',
  --       \ 'vista', 'vista_kind', 'tagbar', 'lsp-hover', 'clap_input', 'fzf',
  --       \ 'any-jump', 'gina-status', 'gina-commit', 'gina-log', 'minimap',
  --       \ 'quickpick-filter', 'lsp-quickpick-filter', 'lspinfo'
  --       \ ]
  --     augroup user_plugin_indentguides
  --       autocmd!
  --       autocmd BufEnter *
  --         \ if ! empty(&l:filetype) && empty(&buftype) && ! &previewwindow
  --         \|   if g:indent_guides_autocmds_enabled == 0 && &l:expandtab
  --         \|     IndentGuidesEnable
  --         \|   elseif g:indent_guides_autocmds_enabled == 1 && ! &l:expandtab
  --         \|     IndentGuidesDisable
  --         \|   endif
  --         \| elseif g:indent_guides_autocmds_enabled == 1
  --         \|   IndentGuidesDisable
  --         \| endif
  --     augroup END

  -- - repo: norcalli/nvim-colorizer.lua
  --   if: has('nvim-0.4')
  --   on_event: FileType
  --   hook_post_source: lua require('plugins.colorizer')

  -- - repo: rhysd/committia.vim
  --   on_event: BufReadPost
  --   depends: nvim-treesitter
  --   hook_source: |-
  --     let g:committia_min_window_width = 30
  --     let g:committia_edit_window_width = 75
  --     let g:committia#git#status_cmd = '-c color.status=false status -sb'

  -- - repo: deris/vim-shot-f
  --   on_map: { nxo: <Plug> }
  --   hook_add: let g:shot_f_no_default_key_mappings = 1

  -- - repo: VonHeikemen/fine-cmdline.nvim
  --   on_event: VimEnter
  --   on_cmd: [FineCmdline]
  --   depends: [nui.nvim]
  --   hook_post_source: lua require('plugins.fine-cmdline')

  -- - repo: vim-airline/vim-airline
  --   depends: [vim-fugitive]
  --   on_event: VimEnter

  -- - repo: kevinhwang91/promise-async
  -- - repo: kevinhwang91/nvim-ufo
  --   on_event: VimEnter
  --   depends: [promise-async, nvim-treesitter]
  --   hook_post_source: lua require('plugins.nvim-ufo')

  -- - repo: rcarriga/nvim-notify
  --   on_event: VimEnter
  --   hook_post_source: lua require('plugins.nvim-notify')

  -- completion and code analysis
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },

  'hrsh7th/cmp-nvim-lsp',
  'kosayoda/nvim-lightbulb',
  -- - { repo: folke/lua-dev.nvim, on_source: nvim-lspconfig }

  -- - repo: ray-x/lsp_signature.nvim
  --   if: has('nvim-0.6.1')
  --   on_source: nvim-lspconfig

  -- - repo: jose-elias-alvarez/null-ls.nvim
  --   if: has('nvim-0.7')
  --   on_event: VimEnter
  --   depends: nvim-lspconfig
  --   hook_post_source: lua require('plugins.null-ls')

  -- - repo: hrsh7th/nvim-cmp
  --   if: has('nvim-0.5')
  --   on_event: VimEnter
  --   depends: [nvim-autopairs, vim-vsnip]
  --   hook_post_source: lua require('plugins.cmp')

  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/cmp-path',
  -- 'hrsh7th/cmp-emoji',
  -- - { repo: andersevenrud/cmp-tmux, on_source: nvim-cmp }

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

  -- - repo: windwp/nvim-autopairs
  --   if: has('nvim-0.5')
  --   hook_post_source: lua require('nvim-autopairs').setup()

  -- - repo: folke/todo-comments.nvim
  --   if: has('nvim-0.5')
  --   on_source: [telescope.nvim, neovim/nvim-lspconfig]
  --   hook_post_source: lua require('plugins.todo-comments')

  -- - repo: folke/trouble.nvim
  --   if: has('nvim-0.5')
  --   on_cmd: [Trouble, TroubleToggle]

  -- - repo: sindrets/diffview.nvim
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

  -- - repo: rmagatti/auto-session
  --   if: has('nvim-0.5')
  --   on_event: VimEnter
  --   hook_source: lua require('plugins.auto-session')
  --   hook_add: |-
  --     autocmd user_events StdinReadPre * let g:auto_session_enabled = v:false

  "sbdchd/neoformat",

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

  -- - repo: AndrewRadev/splitjoin.vim
  --   on_cmd: [SplitjoinJoin, SplitjoinSplit]
  --   hook_add: |-
  --     let g:splitjoin_join_mapping = ''
  --     let g:splitjoin_split_mapping = ''
  --     autocmd user_events FileType go let b:splitjoin_trailing_comma = 1

  -- - repo: phaazon/hop.nvim
  --   on_cmd: [HopWord, HopAnywhere, HopLine, HopChar1, HopChar2]
  --   hook_post_source: lua require('hop').setup()

  -- buffer

  "chrisgrieser/nvim-early-retirement",
}
