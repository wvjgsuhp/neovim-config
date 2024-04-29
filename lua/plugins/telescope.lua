return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", cond = vim.g.is_unix == 1, build = "make" },
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

    -- -- Enable indent-guides in telescope preview
    -- vim.cmd([[
    --   augroup telescope_events
    --     autocmd!
    --     autocmd User TelescopePreviewerLoaded setlocal wrap list
    --   augroup END
    -- ]])
    local flash = function(prompt_bufnr)
      require("flash").jump({
        pattern = "^",
        search = {
          mode = "search",
          exclude = {
            function(win)
              return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
            end,
          },
        },
        action = function(match)
          local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
          picker:set_selection(match.pos[1] - 1)
        end,
      })
    end

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
        sorting_strategy = "ascending",
        selection_strategy = "closest",
        scroll_strategy = "cycle",
        cache_picker = {
          num_pickers = 3,
          limit_entries = 300,
        },

        prompt_prefix = "❯ ",
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
        winblend = 8,
        color_devicons = true,

        mappings = {
          i = {
            ["jj"] = { "<Esc>", type = "command" },
            ["jk"] = { "<Esc>", type = "command" },
            ["kk"] = { "<Esc>", type = "command" },
            ["kj"] = { "<Esc>", type = "command" },

            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,

            ["<Down>"] = actions.cycle_history_next,
            ["<Up>"] = actions.cycle_history_prev,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,

            ["<C-k>"] = actions.preview_scrolling_up,
            ["<C-j>"] = actions.preview_scrolling_down,

            ["<C-l>"] = actions.select_vertical,

            ["<C-u>"] = false,
          },

          n = {
            ["q"] = actions.close,
            ["<Esc>"] = actions.close,

            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,

            ["<C-k>"] = actions.preview_scrolling_up,
            ["<C-j>"] = actions.preview_scrolling_down,

            ["v"] = actions.toggle_selection + actions.move_selection_next,

            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<Leader>j"] = actions.select_horizontal,
            ["J"] = actions.select_horizontal,
            ["<Leader>l"] = actions.select_vertical,
            ["L"] = actions.select_vertical,
            ["<C-l>"] = actions.select_vertical,
            ["<Leader>t"] = {
              actions.select_tab,
              type = "action",
              opts = { nowait = true },
            },
            ["s"] = flash,
          },
        },
      },

      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
    })

    if vim.g.is_unix == 1 then
      require("telescope").load_extension("fzf")
    end
  end,
  keys = {
    { "<Leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<C-o>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<Leader>fg", "<cmd>Telescope grep_string search=<CR>", desc = "Fuzzy find words" },
    { "<C-f>", "<cmd>Telescope grep_string search=<CR>", desc = "Fuzzy find words" },
    { "<Leader>fz", "<cmd>Telescope grep_string<CR>", desc = "Fuzzy find words under cursor" },
    { "<Leader>fib", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy find in buffer" },
    { "<Leader>fb", "<cmd>Telescope buffers<CR>", desc = "Fuzzy find buffers" },
    { "<Leader>fm", "<cmd>Telescope live_grep<CR>", desc = "Find words" },
    { "<Leader>fr", "<cmd>Telescope resume<CR>", desc = "Resume Telescope" },
    { "<Leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Find symbols" },
    { "<Leader>dt", "<cmd>Telescope diagnostics<CR>", desc = "Diagnose buffer" },
    { "<Leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnose buffer" },
  },
}
