return {
  "benlubas/molten-nvim",
  version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
  -- dependencies = { "willothy/wezterm.nvim" },
  build = ":UpdateRemotePlugins",
  ft = { "python" },
  init = function()
    vim.g.molten_output_win_max_height = 12
    -- vim.g.molten_image_provider = "wezterm"
    vim.g.molten_output_virt_lines = true
    vim.g.molten_auto_open_output = false
    vim.g.molten_virt_text_output = true
  end,
  keys = {
    { "<Leader>mi", "<cmd>MoltenInit<CR>", desc = "Initialize Molten" },
    { "<Localleader>e", "<cmd>MoltenEvaluateLine<CR>", desc = "Execute a line of code" },
    { "<Localleader>e", ":<C-u>MoltenEvaluateVisual<CR>gv<Esc>", mode = "v", desc = "Execute code chunk" },
    {
      "<Leader>me",
      "<cmd>noautocmd MoltenEnterOutput<CR><cmd>noautocmd MoltenEnterOutput<CR>",
      desc = "Enter Molten output",
    },
  },
}
