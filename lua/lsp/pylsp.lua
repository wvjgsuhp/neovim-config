return function(config)
  config.settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { "E501", "W503" },
          maxLineLength = 112,
        },
      },
    },
  }
end
