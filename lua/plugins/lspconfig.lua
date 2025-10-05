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
      "dockerls",
      "html",
      "lua_ls",
      "pylsp",
      "r_language_server",
      "rust_analyzer",
      "texlab",
      "ts_ls",
      "yamlls",
      "postgres_lsp",
    }

    vim.lsp.enable(servers)

    local constants = require("constants")
    local utils = require("utils")

    local activate_lsp_highlight = function(client, buffer_number)
      if vim.b.has_lsp_highlight or not client.server_capabilities.documentHighlightProvider then
        return
      end
      vim.b.has_lsp_highlight = true

      utils.autocmd("CursorHold", {
        buffer = buffer_number,
        callback = function()
          vim.lsp.buf.clear_references()
          vim.lsp.buf.document_highlight()
        end,
      })

      utils.autocmd({ "CursorMoved", "BufLeave" }, {
        buffer = buffer_number,
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

      -- Short-circuit for Helm template files
      if vim.bo[buffer_number].buftype ~= "" or vim.bo[buffer_number].filetype == "helm" then
        vim.diagnostic.enable(false, { bufnr = buffer_number })
        return
      end

      -- TODO: enable if no treesitter
      client.server_capabilities.semanticTokensProvider = nil
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end

      utils.map_buf("n", "K", vim.lsp.buf.hover)
      utils.map_buf("n", "gD", vim.lsp.buf.declaration)
      utils.map_buf("n", "gd", vim.lsp.buf.definition)
      utils.map_buf("n", "gr", vim.lsp.buf.references)
      utils.map_buf("n", "gy", vim.lsp.buf.type_definition)
      utils.map_buf("n", "gi", vim.lsp.buf.implementation)
      utils.map_buf("n", ",rn", vim.lsp.buf.rename)
      utils.map_buf("n", "<Leader>ds", vim.lsp.buf.code_action)
      utils.map_buf("n", "H", lsp_toggle_inlay_hint)
      utils.map_buf({ "n", "x" }, ",f", lsp_format)

      activate_lsp_highlight(client, buffer_number)
    end

    require("lspconfig.ui.windows").default_options.border = constants.border.none

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        on_attach(client)
      end,
    })
  end,
}
