return {
  "saghen/blink.cmp",
  -- enabled = false,
  -- optional: provides snippets for the snippet source
  dependencies = { "rafamadriz/friendly-snippets" },

  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  opts = function()
    local constants = require("constants")

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    return {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "snippet_forward", "fallback" },
        ["<C-b>"] = { "snippet_backward", "fallback" },
        ["<C-o>"] = { "select_accept_and_enter", "fallback" },
      },
      signature = { enabled = true },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "normal",
        kind_icons = constants.icons.kinds,
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = {
          auto_show = false,
          window = {
            border = constants.border.hint,
          },
        },
        menu = {
          border = constants.border.completion,
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  return ctx.kind_icon .. string.sub(ctx.icon_gap, 2)
                end,
              },
              label = { width = { fill = true, max = 21 } },
            },
            gap = 1,
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
          },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    }
  end,
  opts_extend = { "sources.default" },
}
