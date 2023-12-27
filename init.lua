vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.g.toggle_theme_icon = ""
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.termencoding = "utf-8"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.numberwidth = 4
vim.opt.scrolloff = 8
-- vim.opt.signcolumn = "no"
-- vim.opt.colorcolumn = "80"
-- vim.opt.updatetime = 50
-- vim.o.autochdir = true



vim.cmd [[



]]



-- for powershell
vim.cmd [[
set shell=powershell.exe
set shellxquote=
let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
let &shellquote   = ''
let &shellpipe    = '| Out-File -Encoding UTF8 %s'
let &shellredir   = '| Out-File -Encoding UTF8 %s'

" let &shell='"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -f'
" let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
" let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
" let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
" let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
" set shellquote= shellxquote= 
]]

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
