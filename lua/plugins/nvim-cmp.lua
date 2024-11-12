return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "windwp/nvim-autopairs",
  },
  config = function()
    local constants = require("constants")
    local luasnip = require("luasnip")
    local cmp = require("cmp")
    local utils = require("utils")

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      enabled = function()
        return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
      end,

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, completion)
          local kind = utils.ensure_string(completion.kind)
          local icon = constants.icons.kinds[kind]

          completion.kind = icon and " " .. icon or ""
          completion.menu = " " .. kind
          completion.menu_hl_group = "CmpItemKind" .. kind

          if completion.abbr:len() > 31 then
            completion.abbr = completion.abbr:sub(1, 31) .. "..."
          end

          return completion
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
          col_offset = -1,
          side_padding = 0,
          border = constants.border.completion,
        },
        documentation = {
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
        { name = "luasnip", priority = 750, max_item_count = 5 },
        { name = "buffer", priority = 500, max_item_count = 5, keyword_length = 2 },
        { name = "path", priority = 250 },
        { name = "nvim_lsp_signature_help" },
        { name = "lazydev", group_index = 0 },
      },
      completion = {
        completeopt = "menu,menuone,noinsert,preview",
      },
      preselect = cmp.PreselectMode.None,
    })

    cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
  end,
}
