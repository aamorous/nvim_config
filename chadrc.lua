---@type ChadrcConfig
local M = {}

local highlights = require "custom.highlights"

vim.g.toggle_theme_icon = ""

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
        return ""
      end)()

      modules[11] = (function()
        local default_sep_icons = {
          block = { left = "", right = "" },
        }
        local config = require("core.utils").load_config().ui.statusline
        local sep_style = config.separator_style
        local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]
        local sep_l = separators["left"]
        local left_sep = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon#" .. "| "

        local current_line = vim.fn.line(".", vim.g.statusline_winid)
        local total_line = vim.fn.line("$", vim.g.statusline_winid)
        local text = math.modf((current_line / total_line) * 100) .. tostring "%%"
        text = string.format("%4s", text)

        text = (current_line == 1 and " 0%%") or text
        text = (current_line == total_line and "Bot") or text

        return left_sep .. "%#St_pos_text#" .. "" .. text .. " "
      end)()

      modules[3] = (function()
        local function stbufnr()
          return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
        end
        local icon = "◾"
        local path = vim.api.nvim_buf_get_name(stbufnr())
        local name = (path == "" and "Empty ") or path:match "([^/\\]+)[/\\]*$"
        if string.find(name, "powershell") or string.find(name, "NvimTree") or string.find(name, "Empty") then
          return ""
        elseif string.find(name, "Trouble") then
          local devicons_present, devicons = pcall(require, "nvim-web-devicons")

          if devicons_present then
            local ft_icon = devicons.get_icon(name)
            icon = (ft_icon ~= nil and ft_icon) or icon
          end

          name = "" .. name .. " "
          return "%#StText# " .. icon .. name
        elseif name ~= "Empty" then
          local devicons_present, devicons = pcall(require, "nvim-web-devicons")

          if devicons_present then
            local ft_icon = devicons.get_icon(name)
            icon = (ft_icon ~= nil and ft_icon) or icon
          end

          name = " " .. name .. " "
        end

        return "%#StText# " .. icon .. name
      end)()

      -- table.insert(modules, modules[2])

      modules[10] = (function()
        -- local fn = vim.fn
        -- local config = require("core.utils").load_config().ui.statusline
        -- local sep_style = config.separator_style

        local function stbufnr()
          return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
        end

        local errors = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.ERROR })
        local warnings = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.WARN })
        local hints = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.HINT })
        local info = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.INFO })

        errors = (errors and errors > 0) and ("%#St_lspError#" .. " " .. errors .. " ") or ""
        warnings = (warnings and warnings > 0) and ("%#St_lspWarning#" .. "  " .. warnings .. " ") or ""
        hints = (hints and hints > 0) and ("%#St_lspHints#" .. "󰛩 " .. hints .. " ") or ""
        info = (info and info > 0) and ("%#St_lspInfo#" .. "󰋼 " .. info .. " ") or ""

        -- if errors > 0 then
        --   return errors
        -- elseif warnings > 0 then
        --   return warnings
        -- elseif hints > 0 then
        --   return hints
        -- elseif info > 0 then
        --   return info
        -- else
        --   return 0
        -- end

        return errors .. warnings .. hints .. info
      end)()

      modules[2] = (function()
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

function SetupLineInfoStatusLine()
  local function displayLineInfo()
    local current_line = vim.fn.line "."
    local total_lines = vim.fn.line "$"
    return string.format("Line %d/%d", current_line, total_lines)
  end

  -- Set the status line with the line information
  vim.cmd 'set statusline=%{luaeval("displayLineInfo()")}'

  -- Autocmd to redraw status line on cursor movement
  vim.api.nvim_exec(
    [[
    augroup LineInfo
      autocmd!
      autocmd CursorMoved,CursorMovedI * lua vim.cmd('redrawstatus')
    augroup END
  ]],
    false
  )
end

return M
