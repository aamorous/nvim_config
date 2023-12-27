local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local util = require "lspconfig/util"
local lspconfig = require "lspconfig"
local pid = vim.fn.getpid()

local servers = { "html", "cssls", "tsserver", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local omnisharp_bin = "C:/Users/Admin/AppData/Local/omnisharp-vim/omnisharp-roslyn/OmniSharp.exe"
lspconfig.omnisharp.setup {
  opts = {
    servers = {
      omnisharp = {
        handlers = {
          ["textDocument/definition"] = function(...)
            return require("omnisharp_extended").handler(...)
          end,
        },
        keys = {
          {
            -- "gd",
            function()
              require("omnisharp_extended").telescope_lsp_definitions()
            end,
            desc = "Goto Definition",
          },
        },
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
      },
    },
  },
  on_atach = on_attach,
  capabilities = capabilities,
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {}),
  vim.api.nvim_set_keymap("n", "gd", ":OmniSharpGotoDefinition<CR>", { noremap = true, silent = true }),
  vim.api.nvim_set_keymap("n", "gD", ":OmniSharpPreviewDefinioton<CR>", { noremap = true, silent = true }),
  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}),
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {}),
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {}),
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {}),
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, {}),
}

lspconfig.rust_analyzer.setup {
  on_atach = on_attach,
  capabilities = capabilities,

  vim.keymap.set("n", "<space>f", function()
    local ext = vim.fn.expand "%:e"
    if ext == "rs" then
      vim.fn.execute "RustFmt"
    else
    end
  end),

  filetypes = { "rust" },
  root_dir = util.root_pattern "Cargo.toml",
  settings = {
    ["rust_analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
}
