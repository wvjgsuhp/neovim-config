return function(config)
  config.settings = {
    pylsp = {
      plugins = {
        -- rope_autoimport = {
        --   enabled = true,
        -- },
        pycodestyle = {
          ignore = { "E501", "W503" },
          maxLineLength = 112,
        },
      },
    },
  }
end
