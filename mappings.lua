-- Execute File based on extension
function GetRunCommand()
  local file_name = vim.fn.expand "%:t"
  local file_extension = vim.fn.expand "%:e"
  local file_without_extension = file_name:gsub("%..*$", "")

  if file_extension ~= "" then
    ToggleVerticalTerminal()
  end

  if file_extension == "cs" then
    return "dotnet run "
  elseif file_extension == "js" then
    return "node " .. file_name
  elseif file_extension == "rs" then
    return "cargo run " .. file_name
  elseif file_extension == "go" then
    return "go run " .. file_name
  elseif file_extension == "ts" then
    return "npx ts-node " .. file_name
  elseif file_extension == "cpp" then
    return ("g++ " .. file_name .. " | ./" .. file_without_extension .. ".exe")
  else
    print "Unsupported file type"
  end
end

local M = {}

M.general = {

  n = {

    ["<A-r>"] = {
      string.format "<Cmd>:w! | lua require('nvterm.terminal').send('cd '..vim.fn.expand('%%:p:h')..'; ' .. GetRunCommand() .. '\\r', 'vertical')<CR>",
      "Run current file",
    },

    ["<leader>P"] = {
      function()
        require("nvterm.terminal").new "float"
        require("nvterm.terminal").toggle "float"
        local cmd =
          string.format ":w! | lua require('nvterm.terminal').send('cd '..vim.fn.expand('%%:p:h')..'\\r', 'float')"
        vim.fn.execute(cmd)
        function OpenTerm()
          require("nvterm.terminal").toggle "float"
        end
        OpenTerm()
        print "Directory opened"
      end,
      "Open current directory in float terminal",
    },

    ["<leader>_"] = {
      function()
        local dir = vim.fn.expand "%:h"
        vim.fn.execute "cd %:h"
        print("File location set to " .. dir)
      end,
      "Set file locaton of the opened current file ",
    },

    ["<leader>-"] = {
      function()
        vim.fn.execute "cd C:\\Users\\Admin\\source"
        print "File location set to C:\\Users\\Admin\\source"
      end,
      "Set file locaton to repos",
    },

    ["<leader>code"] = {
      function()
        print "File opened in VS Code"
        OpenFileInVSC()
      end,
    },

    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating terminal term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<leader>s"] = { "<cmd>w! <CR>", "Save" },

    ["<C-/>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },

    ["\\"] = { "<cmd>:vsplit <CR>", "Vertical split" },

    ["<A-v"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle float terminal",
    },

    ["<C-\\>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
    },

    ["Q"] = { "<cmd>wa! | q!<CR>", "Quit" },

    ["<A-n>"] = { "<cmd>NvimTreeToggle<CR>", "Toggle NvimTree" },

    ["<Space>p"] = { "<cmd>pwd<CR>", "Print working directory" },

    ["<Space>."] = {
      function()
        OpenExplorerAndPrintDirectory()
      end,
      "Open Explorer and print current directory",
    },

    ["<Space><"] = {
      function()
        GoUpAndPrintDirectoryChange()
      end,
      "Change directory and print current directory",
    },

    ["<leader>N"] = {
      function()
        OpenNewTerminalInNewWindow()
      end,
      "Open new terminal in new window",
    },

    ["I"] = {
      function()
        vim.api.nvim_command ":normal! o"
      end,
      "Insert newline and return to normal mode",
    },

    ["<C-p>"] = {
      function()
        vim.api.nvim_command ":normal! o"
        vim.api.nvim_command ":normal! p"
      end,
      "Paste from clipboard",
    },
    ["t"] = {
      function()
        require("trouble").toggle "document_diagnostics"
      end,
    },
  },
  v = {

    [">"] = { ">gv", "indent" },
  },
  t = {
    ["<A-r>"] = {
      function() end,
      "Change directory and run current file",
    },

    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating terminal term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },
  },
}

function OpenExplorerAndPrintDirectory()
  vim.fn.execute "!explorer ."
  print "File Explorer opened"
end

function GoUpAndPrintDirectoryChange()
  vim.fn.execute "cd.. "
  local curdir = vim.fn.getcwd()
  print(curdir)
end

function OpenFileInVSC()
  local current_file = vim.fn.expand "%:p"
  local cmd

  if vim.fn.has "win32" == 1 then
    -- On Windows
    cmd = "code " .. current_file
  elseif vim.fn.has "mac" == 1 or vim.fn.has "unix" == 1 then
    -- On macOS or Unix-based systems
    cmd = "code " .. current_file
  else
    -- Unsupported platform
    print "Unsupported platform for opening file explorer."
    return
  end

  vim.fn.system(cmd)
end

function ToggleVerticalTerminal()
  require("nvterm.terminal").toggle "vertical"
  local current_mode = vim.fn.mode()

  if current_mode == "i" or current_mode == "R" then
    -- Currently in insert or replace mode, switch to normal mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  else
    -- Currently in normal mode, switch to insert mode and revers switch
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true), "n", true)
    vim.fn.timer_start(500, function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-x>", true, false, true), "i", true)
    end)
  end
end

function OpenNewTerminalInNewWindow()
  vim.fn.execute ":!wt"
  print "Opened New Terminal"
end

return M
