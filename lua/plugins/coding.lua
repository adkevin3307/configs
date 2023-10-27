return {
    {
        "ntpeters/vim-better-whitespace",
        config = function()
            vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = require("onedark.colors").red })
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "python", "bash" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                }
            }
        end
    },
    {
        "numToStr/Comment.nvim",
        opts = {
            toggler = {
                line = "<Leader>cc"
            },
            opleader = {
                line = "<Leader>cc",
                block = "<Leader>bc"
            },
            mapping = {
                basic = false,
                extra = false
            }
        }
    },
    {
        "vim-autoformat/vim-autoformat",
        config = function()
            local keymap = vim.keymap.set

            keymap("n", "<F4>", ":Autoformat<CR>", { noremap = true })

            vim.g.formatters_python = { "black" }
            vim.g.formatdef_black = '"black - --line-length=200 --skip-string-normalization"'
        end
    }
}
