---@type ChadrcConfig
local M = {}

local highlights = require "custom.highlights"

M.ui = {
  theme = "rosepine",
  theme_toggle = { "rosepine", "tokyodark" },

  transparency = true,

  lsp_semantic_tokens = true,
  hl_override = highlights.override,
  hl_add = highlights.add,
  telescope = { style = "borderless" }, -- borderless / bordered

  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "simple", -- colored / simple
  },

  statusline = {
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    separator_style = "block",
    overriden_modules = function(modules)
      modules[13] = (function()
        return ""
      end)()

      modules[12] = (function()
        return " "
      end)()

      modules[11] = (function()
        return ""
      end)()

      modules[10] = (function()
        return ""
      end)()

      -- table.insert(
      --   modules,
      --   1,
      --   (function()
      --     return " "
      --   end)()
      -- )

      -- table.insert(modules, modules[2])

      modules[3] = (function()
        return "%##"
      end)()

      modules[4] = (function()
        return "%##"
      end)()
    end,
  },

  tabufline = {
    show_numbers = false,
    enabled = true,
    lazyload = true,
    overriden_modules = nil,
  },
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

return M
