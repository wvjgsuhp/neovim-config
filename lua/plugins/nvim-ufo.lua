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

    local function virtual_text_handler(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local fill_char = "─ "
      local suffix = ""
      local targetWidth = tonumber(vim.o.colorcolumn)
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)

          break
        end

        if curWidth < targetWidth then
          local n_repeats = math.floor((targetWidth - curWidth - 2) / vim.fn.strdisplaywidth(fill_char))
          suffix = " " .. (fill_char):rep(n_repeats)
        end

        curWidth = curWidth + chunkWidth
      end

      table.insert(newVirtText, { suffix, "Comment" })
      return newVirtText
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
