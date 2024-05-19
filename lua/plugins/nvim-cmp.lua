return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "onsails/lspkind-nvim",
    "saadparwaiz1/cmp_luasnip",
    "windwp/nvim-autopairs",
  },
  config = function()
    local constants = require("constants")

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local lspkind = require("lspkind")
    local luasnip = require("luasnip")

    require("lspkind").init({
      mode = "symbol",
      preset = "default",
      symbol_map = constants.icons,
    })

    local source_mapping = {
      buffer = "[Buffer]",
      luasnip = "[LuaSnip]",
      nvim_lsp = "[LSP]",
      vsnip = "[VSnip]",
      look = "[Look]",
      path = "[Path]",
      spell = "[Spell]",
    }

    local cmp = require("cmp")
    cmp.setup({
      enabled = function()
        return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
        -- return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
      end,

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = lspkind.cmp_format({ mode = "symbol", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "  " .. (source_mapping[entry.source.name] or "")

          return kind
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-k>"] = cmp.mapping.scroll_docs(-4),
        ["<C-j>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-q>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-n>"] = cmp.mapping(function(fallback)
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-b>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = {
          winhighlight = "Normal:Normal,FloatBorder:Normal,Search:None,CursorLine:PmenuSel",
          -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None,CursorLine:PmenuSel",
          col_offset = -1,
          side_padding = 0,
          border = constants.border.completion,
        },
        documentation = {
          -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          winhighlight = "Normal:Normal,FloatBorder:Normal,Search:None",
          border = constants.border.hint,
        },
      },
      duplicates = {
        nvim_lsp = 1,
        luasnip = 1,
        buffer = 1,
        path = 1,
      },
      sources = {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
        { name = "nvim_lsp_signature_help" },
      },
      completion = {
        completeopt = "menu,menuone,noinsert,preview",
      },
      preselect = cmp.PreselectMode.None,
    })

    cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
  end,
}
