return {
  "kevinhwang91/nvim-ufo",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "kevinhwang91/promise-async",
  },
  config = function()
    vim.o.foldcolumn = "0" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

    local function virtual_text_handler(virtual_text, lnum, endLnum, width, truncate)
      local new_virtual_text = {}
      local fill_char = " ─ "
      local suffix = ""
      local colorcolumn = tonumber(vim.o.colorcolumn)
      local target_width = math.min(colorcolumn and colorcolumn or 80, width)

      local total_width = 0
      for _, chunk in ipairs(virtual_text) do
        local chunk_text = chunk[1]
        local chunk_width = vim.fn.strdisplaywidth(chunk_text)
        if target_width > total_width + chunk_width then
          table.insert(new_virtual_text, chunk)
        else
          chunk_text = truncate(chunk_text, target_width - total_width)
          local hl_group = chunk[2]
          table.insert(new_virtual_text, { chunk_text, hl_group })
          chunk_width = vim.fn.strdisplaywidth(chunk_text)

          break
        end

        if total_width < target_width then
          local n_repeats = math.floor((target_width - total_width - 2) / vim.fn.strdisplaywidth(fill_char))
          suffix = " " .. fill_char:rep(n_repeats)
        end

        total_width = total_width + chunk_width
      end

      table.insert(new_virtual_text, { suffix, "Comment" })
      return new_virtual_text
    end

    -- Option 3: treesitter as a main provider instead
    -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
    -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
    require("ufo").setup({
      fold_virt_text_handler = virtual_text_handler,
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    })
  end,
}
