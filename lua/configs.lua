local opt = vim.opt

opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.number = true
opt.mouse = "a"
opt.wrap = false

opt.backup = false
opt.writebackup = false
opt.updatetime = 100
opt.shortmess:append({c = true})

opt.signcolumn = "yes"
opt.cursorline = true

local keymap = vim.keymap.set

keymap("n", "<C-h>", "<Left>")
keymap("n", "<C-j>", "<Down>")
keymap("n", "<C-k>", "<Up>")
keymap("n", "<C-l>", "<Right>")

keymap("i", "<C-h>", "<Left>")
keymap("i", "<C-j>", "<Down>")
keymap("i", "<C-k>", "<Up>")
keymap("i", "<C-l>", "<Right>")

keymap("n", "<Leader>n", ":nohl<CR>")
keymap("n", "<C-q>", ":bdelete<CR>")
keymap("n", "*", "*``")
