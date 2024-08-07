return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    local constants = require("constants")
    local utils = require("utils")
    local commands = require("neo-tree.sources.buffers.commands")
    local git_signs = constants.icons.git_signs

    require("neo-tree").setup({
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      window = {
        mappings = {
          ["<C-n>"] = "add",
          ["s"] = {
            function(_)
              require("flash").jump()
            end,
            desc = "Flash",
          },
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["o"] = {
            function(state)
              local path = state.tree:get_node().path
              vim.cmd('!explorer.exe "' .. (path:gsub("/", "\\\\")) .. '"')
            end,
            desc = "Open file with system",
          },
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/370#discussioncomment-4144005
          ["n"] = {
            function(state)
              local node = state.tree:get_node()
              local filename = node.name

              vim.fn.setreg('"', filename)
              vim.notify("Copied: " .. filename)
            end,
          },
          ["y"] = {
            function(state)
              local node = state.tree:get_node()
              local filepath = node:get_id()
              local relative_path = "./" .. vim.fn.fnamemodify(filepath, ":.")

              vim.fn.setreg('"', relative_path)
              vim.notify("Copied: " .. relative_path)
            end,
          },
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local filepath = node:get_id()
              local absolute_path = filepath

              vim.fn.setreg('"', absolute_path)
              vim.notify("Copied: " .. absolute_path)
            end,
          },
          ["-"] = {
            function(state)
              local path = state.tree:get_node().path
              vim.cmd("!git add '" .. path .. "'")
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
          ["<Esc>"] = {
            function(_)
              vim.cmd("q")
            end,
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
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    })

    utils.autocmd_filetype(
      "neo-tree",
      vim.schedule_wrap(function()
        vim.opt_local.winblend = 0
      end)
    )
  end,
  keys = {
    { "<Leader>e", "<Cmd>Neotree float<CR>", desc = "Explore files" },
    { "<Leader>gs", "<cmd>Neotree float git_status<CR>", desc = "Show git status" },
    { "<Leader>fe", "<Cmd>Neotree float reveal<CR>", desc = "Find current buffer in explorer" },
  },
  cmd = { "Neotree" },
}
