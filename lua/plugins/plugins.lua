return {
  -- "nvim-lua/plenary.nvim",
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
      vim.g.vmt_auto_update_on_save = 1
    end,
    cmd = "GenTocGFM",
  },
  {
    "folke/which-key.nvim",
    config = true,
    cmd = "WhichKey",
    keys = {
      { "<Leader>k", "<cmd>WhichKey<CR>" },
    },
  },

  -- interface

  "MunifTanjim/nui.nvim",
  "romainl/vim-cool",
  -- {
  --   "rhysd/accelerated-jk",
  --   keys = {
  --     { "j", "<Plug>(accelerated_jk_gj)zz" },
  --     { "k", "<Plug>(accelerated_jk_gk)zz" },
  --   },
  -- },

  -- coding

  "folke/neodev.nvim",
  {
    "folke/trouble.nvim",
    keys = {
      { "<Leader>dd", "<cmd>Trouble document_diagnostics<cr>", desc = "Diagnose the current buffer" },
      -- { "<Leader>dw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Diagnose the current workspace" },
    },
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    opts = {
      ui = {
        icons = {
          package_installed = " ",
          package_pending = " ",
          package_uninstalled = " ",
        },
      },
    },
    cmd = { "Mason", "MasonInstall" },
  },
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
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
    "goerz/jupytext.vim",
    ft = { "json" },
    config = function()
      vim.g.jupytext_enabled = 1
      vim.g.jupytext_command = "jupytext"
      vim.g.jupytext_fmt = "py"
      vim.g.jupytext_to_ipynb_opts = "--to=ipynb --update"
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
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

  -- syntax

  "tpope/vim-sleuth",

  -- Vimscript syntax/indent plugins

  {
    "jalvesaq/Nvim-R",
    config = function()
      vim.g.R_assign = 0
      vim.g.R_nvim_wd = 0
    end,
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
    config = true,
  },

  -- debug

  { "nvim-treesitter/playground", cmd = { "TSHighlightCapturesUnderCursor" } },
}
