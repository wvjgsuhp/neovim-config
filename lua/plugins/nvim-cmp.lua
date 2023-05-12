return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    -- "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-path",
  },
  config = function()
    -- plugin: nvim-cmp
    -- see: https://github.com/hrsh7th/nvim-cmp
    -- rafi settings

    local cmp = require("cmp")

    -- Source setup. Helper function for cmp source presets.
    _G.cmp_get_sources = function(arr)
      local config = {
        buffer = { name = "buffer" },
        nvim_lsp = { name = "nvim_lsp" },
        nvim_lua = { name = "nvim_lua" },
        path = { name = "path" },
        emoji = { name = "emoji" },
        vsnip = { name = "vsnip" },
        tmux = { name = "tmux", option = { all_panes = true } },
        latex = { name = "latex_symbols" },
      }
      local sources = {}
      for _, name in ipairs(arr) do
        sources[#sources + 1] = config[name]
      end
      return sources
    end

    --     
    --    ⮡
    -- Labels for completion candidates.
    local completion_labels = {
      nvim_lsp = "[LSP]",
      nvim_lua = "[Lua]",
      -- buffer   = "[Buf]",
      spell = "[Spell]",
      path = "[Path]",
      -- vsnip    = "[VSnip]",
      tmux = "[Tmux]",
    }

    -- Detect if words are before cursor position.
    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
      end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    -- Feed proper terminal codes
    local feedkey = function(key, mode)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end

    -- For LSP integration, see lspconfig.lua

    -- :h cmp
    cmp.setup({

      -- Set default cmp sources
      sources = cmp_get_sources({
        "nvim_lsp",
        "buffer",
        "path",
        "vsnip",
        "tmux",
      }),

      snippet = {
        expand = function(args)
          -- Using https://github.com/hrsh7th/vim-vsnip for snippets.
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-c>"] = function(fallback)
          cmp.close()
          fallback()
        end,
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"]() == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      window = {
        completion = cmp.config.window.bordered({
          border = "none",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          border = "none",
          winhighlight = "FloatBorder:NormalFloat",
        }),
      },

      -- window = {
      -- 	completion = {
      -- 		border = { '', '', '', '', '', '', '', '' },
      -- 		winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
      -- 	},
      -- 	documentation = {
      -- 		max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
      -- 		max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
      -- 		border = { '', '', '', ' ', '', '', '', ' ' },
      -- 		winhighlight = 'FloatBorder:NormalFloat',
      -- 	},
      -- },

      -- documentation = {
      -- 	border = 'rounded',
      -- 	winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
      -- },

      -- view = {
      -- 	entries = 'native',
      -- },

      formatting = {
        format = function(entry, vim_item)
          -- Prepend with a fancy icon
          -- See lua/lsp_kind.lua
          local symbol = require("lsp_kind").preset()[vim_item.kind]
          if symbol ~= nil then
            vim_item.kind = symbol .. (vim.g.global_symbol_padding or " ") .. vim_item.kind
          end

          -- Set menu source name
          if completion_labels[entry.source.name] then
            vim_item.menu = completion_labels[entry.source.name]
          end

          vim_item.dup = ({
            nvim_lua = 0,
            buffer = 0,
          })[entry.source.name] or 1

          return vim_item
        end,
      },
    })

    -- Completion sources according to specific file-types.
    cmp.setup.filetype({ "markdown", "help", "text" }, {
      sources = cmp_get_sources({ "emoji", "nvim_lsp", "buffer", "path", "vsnip", "tmux" }),
    })

    cmp.setup.filetype({ "lua" }, {
      sources = cmp_get_sources({ "nvim_lua", "nvim_lsp", "buffer", "path", "vsnip", "tmux" }),
    })
  end,
}
--
-- return {
--   "hrsh7th/nvim-cmp",
--   dependencies = {
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-nvim-lua",
--     "hrsh7th/cmp-path",
--     --'hrsh7th/cmp-calc',
--     "hrsh7th/vim-vsnip",
--     "hrsh7th/vim-vsnip-integ",
--     --'rafamadriz/friendly-snippets',
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-nvim-lsp-document-symbol",
--     "hrsh7th/cmp-nvim-lsp-signature-help",
--     -- "rcarriga/cmp-dap",
--     "onsails/lspkind-nvim",
--     "David-Kunz/cmp-npm",
--   },
--   config = function()
--     require("cmp-npm").setup()
--     require("lspkind").init({
--       mode = "symbol_text",
--       preset = "default",
--       symbol_map = {
--         Text = "",
--         Method = "",
--         Function = "",
--         Constructor = "",
--         Variable = "",
--         Class = "",
--         Interface = "",
--         Module = "",
--         Property = "",
--         Unit = "",
--         Value = "",
--         Enum = "了",
--         Keyword = "",
--         Snippet = "﬌",
--         Color = "",
--         File = "",
--         Folder = "",
--         EnumMember = "",
--         Constant = "",
--         Struct = "",
--         Operator = "",
--       },
--     })
--
--     local cmp = require("cmp")
--     cmp.setup({
--       enabled = function()
--         return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" --[[ or require("cmp_dap").is_dap_buffer() ]]
--       end,
--       formatting = {
--         format = function(entry, vim_item)
--           -- fancy icons and a name of kind
--           vim_item.kind = require("lspkind").presets.default[vim_item.kind] -- .. " " .. vim_item.kind
--           -- set a name for each source
--           vim_item.menu = ({
--             buffer = "[Buffer]",
--             nvim_lsp = "[LSP]",
--             vsnip = "[VSnip]",
--             nvim_lua = "[Lua]",
--             cmp_tabnine = "[TabNine]",
--             look = "[Look]",
--             path = "[Path]",
--             spell = "[Spell]",
--             calc = "[Calc]",
--             emoji = "[Emoji]",
--             npm = "[npm]",
--             -- dap = "[DAP]",
--           })[entry.source.name]
--           return vim_item
--         end,
--       },
--       mapping = cmp.mapping.preset.insert({
--         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
--         ["<C-Space>"] = cmp.mapping.complete(),
--         ["<C-e>"] = cmp.mapping.close(),
--         ["<CR>"] = cmp.mapping.confirm({ select = true }),
--       }),
--       snippet = {
--         expand = function(args)
--           vim.fn["vsnip#anonymous"](args.body)
--         end,
--       },
--       sources = {
--         --{ name = "copilot"},
--         --{ name = "nvim_lua" },
--         { name = "nvim_lsp", keyword_length = 1 },
--         -- { name = "dap" },
--         { name = "npm", keyword_length = 3 },
--         { name = "vsnip", keyword_length = 1 },
--         { name = "path" },
--         { name = "calc" },
--         { name = "buffer", keyword_length = 2 },
--         { name = "nvim_lsp_signature_help" },
--       },
--       completion = {
--         completeopt = "menu,menuone,noinsert,preview",
--         --keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
--         --keyword_length = 1,
--       },
--       preselect = cmp.PreselectMode.None,
--     })
--
--     --cmp.setup.cmdline("/", {
--     --    mapping = cmp.mapping.preset.cmdline(),
--     --    sources = {
--     --        { name = "buffer" },
--     --    },
--     --})
--
--     --cmp.setup.cmdline(":", {
--     --    mapping = cmp.mapping.preset.cmdline(),
--     --    sources = cmp.config.sources({
--     --        { name = "path" },
--     --    }, {
--     --        { name = "cmdline" },
--     --    }),
--     --})
--   end,
-- }
