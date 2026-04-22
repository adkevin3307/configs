vim.g.mapleader = " "

vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.wrap = false

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 100
vim.opt.shortmess:append({ c = true })

vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")

vim.keymap.set("n", "<C-q>", "<CMD>bdelete<CR>", { silent = true, desc = "Buffer delete" })
vim.keymap.set("t", "<ESC>", "<ESC><C-\\><C-n>")
