local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

require("configs")

require("lazy").setup({
    spec = {
        { import = "plugins" },
        { import = "plugins.theme" },
        { import = "plugins.editor" },
        { import = "plugins.code" },
    },
    install = {
        missing = true,
        colorscheme = { "onedark" },
    },
})

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
            vim.opt.winhl = "Normal:Floating"

            vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
        end
    end,
})
