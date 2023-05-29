return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  config = function()
    -- Custom window-sizes
    local horizontal_preview_width = function(_, cols, _)
      if cols > 200 then
        return math.floor(cols * 0.7)
      else
        return math.floor(cols * 0.6)
      end
    end

    require("telescope.pickers.layout_strategies").horizontal_merged = function(
      picker,
      max_columns,
      max_lines,
      layout_config
    )
      local layout =
        require("telescope.pickers.layout_strategies").horizontal(picker, max_columns, max_lines, layout_config)

      layout.prompt.borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }
      layout.preview.borderchars = { " ", " ", " ", "▏", " ", " ", " ", " " }

      layout.results.title = ""
      -- layout.results.borderchars = { "─", "│", "─", "│", "│", "│", "┘", "└" }
      -- layout.results.borderchars = { "─", "│", "─", "│", "├", "┤", "┘", "└" }
      layout.results.borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }
      layout.results.line = layout.results.line - 1
      layout.results.height = layout.results.height + 1

      return layout
    end

    -- Enable indent-guides in telescope preview
    vim.cmd([[
      augroup telescope_events
        autocmd!
        autocmd User TelescopePreviewerLoaded setlocal wrap list
      augroup END
    ]])

    local telescope = require("telescope")
    local actions = require("telescope.actions")

    -- Setup Telescope
    -- See telescope.nvim/lua/telescope/config.lua for defaults.
    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        sorting_strategy = "ascending",
        selection_strategy = "closest",
        scroll_strategy = "cycle",
        cache_picker = {
          num_pickers = 3,
          limit_entries = 300,
        },

        prompt_prefix = "❯ ",
        -- ♥ ❥ ➤ 🔭
        -- selection_caret = "▍ ",
        selection_caret = "  ",
        multi_icon = "v",
        set_env = { COLORTERM = "truecolor" },

        -- Flex layout swaps between horizontal and vertical strategies
        -- based on the window width. See :h telescope.layout
        layout_strategy = "horizontal_merged",
        layout_config = {
          width = 0.9,
          height = 0.85,
          prompt_position = "top",
          horizontal = {
            preview_width = horizontal_preview_width,
          },
          vertical = {
            width = 0.75,
            height = 0.85,
            preview_height = 0.4,
            mirror = false,
          },
          flex = {
            -- change to horizontal after 120 cols
            flip_columns = 120,
          },
        },
        path_display = { "truncate" },
        winblend = 0,
        color_devicons = true,

        mappings = {
          i = {
            ["jj"] = { "<Esc>", type = "command" },

            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,

            ["<Down>"] = actions.cycle_history_next,
            ["<Up>"] = actions.cycle_history_prev,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,

            ["<C-b>"] = actions.preview_scrolling_up,
            ["<C-f>"] = actions.preview_scrolling_down,
          },

          n = {
            ["q"] = actions.close,
            ["<Esc>"] = actions.close,

            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,

            ["<C-b>"] = actions.preview_scrolling_up,
            ["<C-f>"] = actions.preview_scrolling_down,

            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,

            ["*"] = actions.toggle_all,
            ["u"] = actions.drop_all,
            ["J"] = actions.toggle_selection + actions.move_selection_next,
            ["K"] = actions.toggle_selection + actions.move_selection_previous,
            ["<Space>"] = {
              actions.toggle_selection + actions.move_selection_next,
              type = "action",
              opts = { nowait = true },
            },

            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["sv"] = actions.select_horizontal,
            ["sg"] = actions.select_vertical,
            ["st"] = actions.select_tab,
            ["l"] = actions.select_default,

            ["!"] = actions.edit_command_line,
          },
        },
      },

      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_cursor({
            layout_config = { width = 0.35, height = 0.35 },
          }),
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    })
    -- Telescope extensions are loaded in each plugin.
  end,
  keys = {
    { "<Leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<c-o>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<Leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Find words" },
    { "<c-f>", "<cmd>Telescope live_grep<CR>", desc = "Find words" },
    { "<Leader>fz", "<cmd>Telescope grep_string<CR>", desc = "Fuzzy find words" },
    { "<Leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy find words" },
  },
}
