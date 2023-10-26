return {
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").load_extension "file_browser"

            local keymap = vim.keymap.set
            local builtin = require("telescope.builtin")

            keymap("n", "<C-f>", ":Telescope file_browser<CR>", {})
            keymap("n", "<C-p>", builtin.buffers, {})
            keymap("n", "<C-t>", builtin.help_tags, {})
            keymap("n", "<C-g>", builtin.git_bcommits, {})
            keymap("n", "<C-r>", builtin.live_grep, {})
        end
    },
    {
        "gelguy/wilder.nvim",
        dependencies = {
            "roxma/nvim-yarp",
            "roxma/vim-hug-neovim-rpc"
        },
        build = ":UpdateRemotePlugins",
        config = function()
            local wilder = require("wilder")
            wilder.setup({ modes = { ":", "/" } })

            wilder.set_option("pipeline", {
                wilder.branch(
                wilder.python_file_finder_pipeline({
                    file_command = { "find", ".", "-type", "f", "-printf", "%P\n" },
                    dir_command = { "find", ".", "-type", "d", "-printf", "%P\n" },
                    filters = { "fuzzy_filter", "difflib_sorter" }
                }),
                wilder.cmdline_pipeline(),
                wilder.python_search_pipeline()
                )
            })

            wilder.set_option("renderer", wilder.popupmenu_renderer(
                wilder.popupmenu_palette_theme({
                    border = "rounded",
                    min_height = 0,
                    max_height = "75%",
                    prompt_position = "top",
                    reverse = 0,

                    highlighter = wilder.basic_highlighter(),
                    left = { " ", wilder.popupmenu_devicons() },
                    right = { " ", wilder.popupmenu_scrollbar() },
                    highlights = {
                        accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
                    }
                })
            ))
        end
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons"
        },
        opts = {},
        config = function()
            require("barbecue").setup({
                create_autocmd = false
            })

            vim.api.nvim_create_autocmd(
                { "WinResized", "BufWinEnter", "CursorHold", "InsertLeave" },
                {
                    group = vim.api.nvim_create_augroup("barbecue.updater", {}),
                    callback = function()
                        require("barbecue.ui").update()
                    end
                }
            )
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                numhl = true,
                current_line_blame = true,
                -- sign_priority = 20
            })

            local keymap = vim.keymap.set

            keymap("n", "<Leader>gn", ":Gitsigns next_hunk<CR>", {})
            keymap("n", "<Leader>gp", ":Gitsigns prev_hunk<CR>", {})
        end
    }
}
