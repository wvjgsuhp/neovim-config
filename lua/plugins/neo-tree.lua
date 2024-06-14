return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = function()
    local constants = require("constants")
    local commands = require("neo-tree.sources.buffers.commands")
    local git_signs = constants.icons.git_signs

    return {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      window = {
        mappings = {
          ["<C-n>"] = "add",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["o"] = {
            function(state)
              local path = state.tree:get_node().path
              vim.cmd("!explorer.exe " .. (path:gsub("/", "\\\\")))
            end,
            desc = "Open file with system",
          },
          ["-"] = {
            function(state)
              local path = state.tree:get_node().path
              vim.cmd("!git add " .. path)
              commands.refresh()
            end,
            desc = "Stage file",
          },
          ["_"] = {
            function(state)
              local path = state.tree:get_node().path
              vim.cmd("!git restore --staged " .. path)
              commands.refresh()
            end,
            desc = "Unstage file",
          },
        },
      },
      default_component_configs = {
        diagnostics = {
          symbols = constants.icons.diagnostics,
        },
        git_status = {
          symbols = {
            -- Change type
            added = git_signs.added,
            deleted = git_signs.removed,
            modified = git_signs.changed,
            renamed = "󰁕",
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
    }
  end,
  keys = {
    { "<Leader>e", "<Cmd>Neotree float<CR>", desc = "Explore files" },
    { "<Leader>gs", "<cmd>Neotree float git_status<CR>", desc = "Show git status" },
    { "<Leader>fe", "<Cmd>Neotree float reveal<CR>", desc = "Find current buffer in explorer" },
  },
  cmd = { "Neotree" },
}
