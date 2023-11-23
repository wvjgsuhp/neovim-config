local utils = require("utils")

local function adjust_lead_multispace()
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

local indent_guide_group = utils.augroup("indent_guide", {})
utils.autocmd({ "BufWinEnter", "BufNewFile" }, {
  pattern = { "*.sql", "*.py" },
  group = indent_guide_group,
  callback = adjust_lead_multispace,
})
