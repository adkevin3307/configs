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

vim.opt.laststatus = 3

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")

vim.keymap.set("n", "<C-q>", "<CMD>bdelete<CR>", { silent = true, desc = "Buffer delete" })
vim.keymap.set("t", "<ESC>", "<ESC><C-\\><C-n>")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        if vim.bo.buftype == "help" then
            local buf = vim.api.nvim_get_current_buf()

            vim.api.nvim_win_close(0, false)

            vim.api.nvim_open_win(buf, true, {
                relative = "editor",
                width = math.floor(vim.o.columns * 0.8),
                height = math.floor(vim.o.lines * 0.8),
                col = math.floor(vim.o.columns * 0.1),
                row = math.floor(vim.o.lines * 0.1),
                style = "minimal",
                border = "rounded",
            })

            vim.opt_local.winbar = ""
        end
    end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    install = {
        missing = true,
        colorscheme = { "onedark" },
    },
    ui = {
        border = "rounded",
    },
})

vim.api.nvim_set_hl(0, "LazyButton", { link = "none" })
vim.api.nvim_set_hl(0, "LazyProp", { link = "none" })
vim.api.nvim_set_hl(0, "LazyDimmed", { link = "none" })
