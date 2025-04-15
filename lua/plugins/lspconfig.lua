return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local servers = {
      "bashls",
      "cssls",
      "html",
      "lua_ls",
      "pylsp",
      "r_language_server",
      "texlab",
      "ts_ls",
      "yamlls",
    }

    vim.lsp.enable(servers)

    local constants = require("constants")
    local utils = require("utils")

    local lsp_highlight_group = utils.augroup("lsp_highlight", {})
    local activate_lsp_highlight = function(client, bufnr)
      if vim.b.has_lsp_highlight or not client.server_capabilities.documentHighlightProvider then
        return
      end
      vim.b.has_lsp_highlight = true

      utils.autocmd("CursorHold", {
        buffer = bufnr,
        group = lsp_highlight_group,
        callback = function()
          vim.lsp.buf.clear_references()
          vim.lsp.buf.document_highlight()
        end,
      })

      utils.autocmd({ "CursorMoved", "BufLeave" }, {
        buffer = bufnr,
        group = lsp_highlight_group,
        callback = vim.lsp.buf.clear_references,
      })
    end

    local function lsp_toggle_inlay_hint()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
    end

    local function lsp_format()
      vim.lsp.buf.format({ timeout_ms = 2000 })
    end

    local function on_attach(client)
      local buffer_number = vim.api.nvim_get_current_buf()

      -- TODO: enable if no treesitter
      client.server_capabilities.semanticTokensProvider = nil
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end

      local function map_buf(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = true, silent = true, noremap = true })
      end

      -- Short-circuit for Helm template files
      if vim.bo[buffer_number].buftype ~= "" or vim.bo[buffer_number].filetype == "helm" then
        require("user").diagnostic.disable(buffer_number)
        return
      end

      map_buf("n", "gD", vim.lsp.buf.declaration)
      map_buf("n", "gd", vim.lsp.buf.definition)
      map_buf("n", "gr", vim.lsp.buf.references)
      map_buf("n", "gy", vim.lsp.buf.type_definition)
      map_buf("n", "gi", vim.lsp.buf.implementation)
      map_buf("n", ",rn", vim.lsp.buf.rename)
      map_buf("n", "<Leader>ds", vim.lsp.buf.code_action)
      map_buf("n", "<Leader>dk", vim.diagnostic.open_float)
      map_buf("n", "H", lsp_toggle_inlay_hint)
      map_buf({ "n", "x" }, ",f", lsp_format)

      activate_lsp_highlight(client, buffer_number)

      -- if client.supports_method("textDocument/rangeFormatting") then
      --   map_buf("x", ",f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
      -- end
    end

    -- global custom location-list diagnostics window toggle.
    utils.noremap("n", "<leader>dN", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
    utils.noremap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>")

    require("lspconfig.ui.windows").default_options.border = constants.border.none

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        on_attach(client)
      end,
    })
  end,
}
