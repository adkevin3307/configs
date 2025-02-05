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
opt.shortmess:append({ c = true })

opt.signcolumn = "yes"
opt.cursorline = true

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

local keymap = vim.keymap.set

keymap("i", "<C-h>", "<Left>")
keymap("i", "<C-j>", "<Down>")
keymap("i", "<C-k>", "<Up>")
keymap("i", "<C-l>", "<Right>")

keymap("n", "<C-q>", "<CMD>bdelete<CR>", { silent = true })
keymap("t", "<ESC>", "<ESC><C-\\><C-n>")
