return {
  "echasnovski/mini.ai",
  event = "VeryLazy",
  config = function()
    local ai = require("mini.ai")
    -- https://github.com/LazyVim/LazyVim/blob/1394070aab122a052b3649f217a6841a8de67447/lua/lazyvim/util/mini.lua
    local function ai_buffer(ai_type)
      local start_line, end_line = 1, vim.fn.line("$")
      if ai_type == "i" then
        -- Skip first and last blank lines for `i` textobject
        local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
        -- Do nothing for buffer with all blanks
        if first_nonblank == 0 or last_nonblank == 0 then
          return { from = { line = start_line, col = 1 } }
        end
        start_line, end_line = first_nonblank, last_nonblank
      end

      local to_col = math.max(vim.fn.getline(end_line):len(), 1)
      return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
    end

    local function ai_indent(ai_type)
      local spaces = (" "):rep(vim.o.tabstop)
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local indents = {}

      for l, line in ipairs(lines) do
        if not line:find("^%s*$") then
          indents[#indents + 1] = { line = l, indent = #line:gsub("\t", spaces):match("^%s*"), text = line }
        end
      end

      local ret = {}

      for i = 1, #indents do
        if i == 1 or indents[i - 1].indent < indents[i].indent then
          local from, to = i, i
          for j = i + 1, #indents do
            if indents[j].indent < indents[i].indent then
              break
            end
            to = j
          end
          from = ai_type == "a" and from > 1 and from - 1 or from
          to = ai_type == "a" and to < #indents and to + 1 or to
          ret[#ret + 1] = {
            indent = indents[i].indent,
            from = { line = indents[from].line, col = ai_type == "a" and 1 or indents[from].indent + 1 },
            to = { line = indents[to].line, col = #indents[to].text },
          }
        end
      end

      return ret
    end

    ai.setup({
      n_lines = 500,
      custom_textobjects = {
        -- clode blocks
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
        -- tags
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        -- digits
        d = { "%f[%d]%d+" },
        e = { -- Word with case
          { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
          "^().*()$",
        },
        i = ai_indent, -- indent
        g = ai_buffer, -- buffer
        u = ai.gen_spec.function_call(), -- u for "Usage"
        U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
      },
    })

    ---@type table<string, string|table>
    local i = {
      [" "] = "Whitespace",
      ['"'] = 'Balanced "',
      ["'"] = "Balanced '",
      ["`"] = "Balanced `",
      ["("] = "Balanced (",
      [")"] = "Balanced ) including white-space",
      [">"] = "Balanced > including white-space",
      ["<lt>"] = "Balanced <",
      ["]"] = "Balanced ] including white-space",
      ["["] = "Balanced [",
      ["}"] = "Balanced } including white-space",
      ["{"] = "Balanced {",
      ["?"] = "User Prompt",
      _ = "Underscore",
      a = "Argument",
      b = "Balanced ), ], }",
      c = "Class",
      d = "Digit(s)",
      e = "Word in CamelCase & snake_case",
      f = "Function",
      g = "Entire file",
      i = "Indent",
      o = "Block, conditional, loop",
      q = "Quote `, \", '",
      t = "Tag",
      u = "Use/call function & method",
      U = "Use/call without dot in name",
    }
    local a = vim.deepcopy(i)
    for k, v in pairs(a) do
      a[k] = v:gsub(" including.*", "")
    end

    local ic = vim.deepcopy(i)
    local ac = vim.deepcopy(a)
    for key, name in pairs({ n = "Next", l = "Last" }) do
      i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
      a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
    end
    require("which-key").register({
      mode = { "o", "x" },
      i = i,
      a = a,
    })
  end,
}
