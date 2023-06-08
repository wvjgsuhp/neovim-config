return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    local utils = require("utils")
    require("noice").setup({
      cmdline = {
        format = {
          cmdline = { pattern = "^:", icon = ":", lang = "vim" },
        },
      },
      views = {
        cmdline_popup = {
          border = {
            style = "single",
            padding = { 0, 1 },
          },
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 89,
            height = "auto",
          },
          win_options = {
            winhighlight = { FloatTitle = "PmenuTitle" },
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 7,
            col = "50%",
          },
          size = {
            width = 89,
            height = 13,
          },
          win_options = {
            winhighlight = { Normal = "Pmenu" },
          },
        },
        hover = {
          border = {
            style = "single",
          },
        },
        confirm = {
          border = {
            style = "single",
          },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = {
          enabled = false,
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    })

    utils.noremap("n", "<Leader>md", "<Cmd>Noice dismiss<CR>")
  end,
}
