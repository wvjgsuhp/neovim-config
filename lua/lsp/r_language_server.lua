return function(config)
  config["flags"] = { debounce_text_changes = 150 }
  config["cmd"] = { "R", "--no-echo", "-e", "languageserver::run()" }
end
