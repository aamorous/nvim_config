local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- {
  --     "OmniSharp/omnisharp-vim",
  --     enabled = true
  -- },

  {
    "dense-analysis/ale",
    enabled = false,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    enabled = true,
    config = function()
      require("rose-pine").setup {
        disable_background = true,
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" }),
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }),
      }
    end,
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_edition = "j"
      vim.g.rustfmt_autosave = 0
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "indent-blankline.nvim",
    enabled = true,
    config = function()
      require("indent_blankline").setup {
        -- for example, context is off by default, use this to turn it on
        show_current_context = true,
        show_current_context_start = false,
        vim.cmd [["
        
        let g:indent_blankline_char = ''
        highlight IndentBlanklineContextChar guifg=#3f3d4a gui=nocombine
        highlight IndentBlanklineContextStart guisp=None gui=nocombine 
        
        "]],
      }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    -- opts = overrides.nvimtree,
    -- config = function()
    --   require("nvim-tree").setup {
    --     disable_netrw = true,
    --     hijack_netrw = true,
    --     hijack_cursor = true,
    --     hijack_unnamed_buffer_when_opening = false,
    --     sync_root_with_cwd = true,
    --     update_focused_file = {
    --       enable = true,
    --       update_root = false,
    --     },
    --     view = {
    --       adaptive_size = false,
    --       side = "right",
    --       width = 20,
    --       preserve_window_proportions = true,
    --     },
    --     git = {
    --       enable = false,
    --       ignore = true,
    --     },
    --     filesystem_watchers = {
    --       enable = true,
    --     },
    --     actions = {
    --       open_file = {
    --         resize_window = true,
    --       },
    --     },
    --     renderer = {
    --       root_folder_label = true,
    --       highlight_git = false,
    --       highlight_opened_files = "none",
    --       indent_width = 1,
    --
    --       indent_markers = {
    --         enable = true,
    --       },
    --
    --       icons = {
    --         show = {
    --           file = false,
    --           folder = true,
    --           folder_arrow = true,
    --           git = false,
    --         },
    --
    --         glyphs = {
    --           default = "󰈚",
    --           symlink = "",
    --           folder = {
    --             default = "",
    --             empty = "",
    --             empty_open = "",
    --             open = "",
    --             symlink = "",
    --             symlink_open = "",
    --             arrow_open = "",
    --             arrow_closed = "",
    --           },
    --           git = {
    --             unstaged = "✗",
    --             staged = "✓",
    --             unmerged = "",
    --             renamed = "➜",
    --             untracked = "★",
    --             deleted = "",
    --             ignored = "◌",
    --           },
    --         },
    --       },
    --     },
    --     filters = {
    --       dotfiles = true,
    --     },
    --   }
    -- end,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    enabled = true,
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "NvChad/nvterm",
    config = function()
      require("nvterm").setup {
        terminals = {
          shell = vim.o.shell,
          list = {},
          type_opts = {
            float = {
              relative = "editor",
              row = 0.3,
              col = 0.24,
              width = 0.5,
              height = 0.4,
              border = "single",
            },
            horizontal = { location = "rightbelow", split_ratio = 0.4 },
            vertical = { location = "rightbelow", split_ratio = 0.5 },
          },
        },
        behavior = {
          autoclose_on_quit = {
            enabled = false,
            confirm = true,
          },
          close_on_exit = true,
          auto_insert = true,
        },
      }
    end,
  },

  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("chatgpt").setup {}
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "nvim-neotest/neotest",
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-jest" {
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
    },
  },

  {
    "mfussenegger/nvim-dap",
    enabled = false,
    config = function()
      local ok, dap = pcall(require, "dap")
      if not ok then
        return
      end
      dap.configurations.typescript = {
        {
          type = "node2",
          name = "node attach",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
        },
      }
      dap.adapters.node2 = {
        type = "executable",
        command = "node-debug2-adapter",
        args = {},
      }
    end,
    dependencies = {
      "mxsdev/nvim-dap-vscode-js",
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
    config = function()
      require("dapui").setup()

      local dap, dapui = require "dap", require "dapui"

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close {}
      end
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },

  {
    "folke/neodev.nvim",
    enabled = false,
    config = function()
      require("neodev").setup {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      }
    end,
  },

  {
    "tpope/vim-fugitive",
    enabled = false,
  },

  { "rbong/vim-flog", enabled = false, dependencies = {
    "tpope/vim-fugitive",
  }, lazy = false },

  { "sindrets/diffview.nvim", enabled = false, lazy = false },

  {
    "ggandor/leap.nvim",
    enabled = false,
    lazy = false,
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },

  {
    "kevinhwang91/nvim-bqf",
    enabled = false,
    lazy = false,
  },

  {
    "folke/trouble.nvim",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      position = "bottom", -- position of the list can be: bottom, top, left, right
      height = 6, -- height of the trouble list when position is top or bottom
      width = 5, -- width of the list when position is left or right
      icons = true, -- use devicons for filenames
      mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
      fold_open = "", -- icon used for open folds
      fold_closed = "", -- icon used for closed folds
      group = true, -- group results by file
      padding = true, -- add an extra new line on top of the list
      cycle_results = true, -- cycle item list when reaching beginning or end of list
      action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = { "o" }, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
        close_folds = { "zM", "zm" }, -- close all folds
        open_folds = { "zR", "zr" }, -- open all folds
        toggle_fold = { "zA", "za" }, -- toggle fold of current file
        previous = "k", -- previous item
        next = "j", -- next item
        help = "?", -- help menu
      },
      multiline = true, -- render multi-line messages
      indent_lines = false, -- add an indent guide below the fold icons
      win_config = { border = "single" }, -- window configuration for floating windows. See |nvim_open_win()|.
      auto_open = false, -- automatically open the list when you have diagnostics
      auto_close = true, -- automatically close the list when you have no diagnostics
      auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      auto_fold = false, -- automatically fold a file trouble list at creation
      auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
      include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- for the given modes, include the declaration of the current symbol in the results
      signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "",
      },
      use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
    },
  },

  {
    "folke/todo-comments.nvim",
    -- enabled = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require("todo-comments").setup()
    end,
  }, -- To make a plugin not be loaded

  {
    "Exafunction/codeium.vim",
    enabled = false,
    lazy = false,
  },

  {
    "glepnir/lspsaga.nvim",
    enabled = false,
  },

  {
    "OmniSharp/omnisharp-vim",
    enabled = true,
    lazy = false,
  },
}

return plugins
