return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "nvim-lua/plenary.nvim",
  },
  config = function()
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
        callback = vim.lsp.buf.document_highlight,
      })
      utils.autocmd("CursorMoved", {
        buffer = bufnr,
        group = lsp_highlight_group,
        callback = vim.lsp.buf.clear_references,
      })
    end

    require("mason").setup()
    require("mason-lspconfig").setup()

    -- Buffer attached
    local on_attach = function(client, bufnr)
      -- TODO: enable if no treesitter
      client.server_capabilities.semanticTokensProvider = nil
      local function map_buf(mode, lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
      end

      -- Short-circuit for Helm template files
      if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
        require("user").diagnostic.disable(bufnr)
        return
      end

      map_buf("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
      map_buf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
      map_buf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
      map_buf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
      map_buf("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
      map_buf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
      map_buf("n", ",rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
      map_buf("n", "<Leader>ds", "<cmd>lua vim.lsp.buf.code_action()<CR>")
      map_buf("n", "<Leader>dk", "<cmd>lua vim.diagnostic.open_float()<CR>")
      map_buf(
        "n",
        "H",
        "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({bufnr = 0}), {bufnr = 0})<CR>"
      )

      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end

      -- Set autocommands conditional on server capabilities
      activate_lsp_highlight(client, bufnr)

      if client.supports_method("textDocument/formatting") then
        if vim.fn.has("nvim-0.8") == 1 then
          map_buf("n", ",f", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>")
        else
          map_buf("n", ",f", "<cmd>lua vim.lsp.buf.formatting(nil, 2000)<CR>")
        end
      end
      if client.supports_method("textDocument/rangeFormatting") then
        map_buf("x", ",f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
      end
    end

    -- Combine base config for each server and merge user-defined settings.
    local function make_config(server_name)
      -- Setup base config for each server.
      local config = {}
      config.on_attach = on_attach
      local cap = vim.lsp.protocol.make_client_capabilities()
      config.capabilities = require("cmp_nvim_lsp").default_capabilities(cap)

      -- user-defined lsp settings
      local exists, user_config = pcall(require, "lsp." .. server_name)
      if exists then
        user_config(config)
      end

      return config
    end

    -- main

    local function setup()
      -- vim.diagnostic.config({
      --   underline = true,
      --   virtual_text = {
      --     source = "if_many",
      --     prefix = "",
      --   },
      --   signs = true,
      --   float = { border = constants.border.error },
      --   severity_sort = true,
      --   update_in_insert = false,
      -- })

      -- set up language servers using nvim-lspconfig
      local lsp_config = require("lspconfig")
      local servers = require("mason-lspconfig").get_installed_servers()

      -- add custom server
      servers[#servers + 1] = "r_language_server"

      for _, server in ipairs(servers) do
        local opts = make_config(server)
        lsp_config[server].setup(opts)
      end

      -- global custom location-list diagnostics window toggle.
      utils.noremap("n", "<leader>dN", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
      utils.noremap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>")

      require("lspconfig.ui.windows").default_options.border = constants.border.none
    end

    setup()
  end,
}
