function _G.adjust_lead_multispace()
  local leads = { "│", "┊" }
  local lead = ""
  for _, lead_char in ipairs(leads) do
    lead = lead .. lead_char
    for _ = 1, vim.bo.shiftwidth - 1 do
      lead = lead .. " "
    end
  end
  vim.opt_local.listchars:append({ leadmultispace = lead })
end
