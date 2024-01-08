vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.swapfile = false
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
vim.opt.termguicolors = true
-- vim.opt.fillchars = { eob = "~" }
-- vim.o.autochdir = true

vim.cmd [[

nmap ; <Enter>
set noshowcmd

]]

-- for powershell
vim.cmd [[
set shell=powershell\ -NoLogo
set shellxquote=
let &shellcmdflag = '-NoLogo'
let &shellquote   = ''
let &shellpipe    = '| Out-File -Encoding UTF8 %s'
let &shellredir   = '| Out-File -Encoding UTF8 %s'
]]
