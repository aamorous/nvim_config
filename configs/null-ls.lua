local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "cs",  } }, -- so prettier works only on these filetypes

  -- b.diagnostics.eslint_d,

  -- Lua
  b.formatting.stylua,

  -- b.formatting.rust_analyzer,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
