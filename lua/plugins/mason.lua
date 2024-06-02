return {
  "williamboman/mason.nvim",
  lazy = true,
  -- https://github.com/williamboman/mason.nvim/discussions/908?sort=top#discussioncomment-8705330
  -- init = function(_)
  --   local pylsp = require("mason-registry").get_package("python-lsp-server")
  --   pylsp:on("install:success", function()
  --     local function mason_package_path(package)
  --       local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
  --       return path
  --     end
  --
  --     local path = mason_package_path("python-lsp-server")
  --     local command = path .. "/venv/bin/pip"
  --     local args = {
  --       "install",
  --       "-U",
  --       -- "pylsp-rope",
  --       -- "python-lsp-black",
  --       -- "python-lsp-isort",
  --       -- "python-lsp-ruff",
  --       -- "pyls-memestra",
  --       "pylsp-mypy",
  --       -- "pylint",
  --       -- "flake8",
  --     }
  --
  --     require("plenary.job")
  --       :new({
  --         command = command,
  --         args = args,
  --         cwd = path,
  --       })
  --       :start()
  --   end)
  -- end,
  opts = {
    ui = {
      icons = {
        package_installed = " ",
        package_pending = " ",
        package_uninstalled = " ",
      },
    },
  },
  cmd = { "Mason", "MasonInstall" },
}
