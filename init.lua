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
]]
