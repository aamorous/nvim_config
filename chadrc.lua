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
    icons = false,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "simple", -- colored / simple
  },

  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "block",
    overriden_modules = nil,
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