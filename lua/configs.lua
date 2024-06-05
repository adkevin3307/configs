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

opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

local keymap = vim.keymap.set

keymap("n", "<C-h>", "<Left>")
keymap("n", "<C-j>", "<Down>")
keymap("n", "<C-k>", "<Up>")
keymap("n", "<C-l>", "<Right>")

keymap("i", "<C-h>", "<Left>")
keymap("i", "<C-j>", "<Down>")
keymap("i", "<C-k>", "<Up>")
keymap("i", "<C-l>", "<Right>")

keymap("n", "<Leader>zc", ":%foldc<CR>", { silent = true })
keymap("n", "<Leader>zo", ":%foldo<CR>", { silent = true })

keymap("n", "<Leader>n", ":nohl<CR>", { silent = true })
keymap("n", "<C-q>", ":bdelete<CR>", { silent = true })
keymap("n", "*", "*``", { silent = true })
