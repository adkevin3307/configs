return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",

            "gbprod/yanky.nvim",
            "nvim-telescope/telescope-file-browser.nvim"
        },
        config = function()
            local actions = require("telescope.actions")

            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<ESC>"] = actions.close,
                            ["<TAB>"] = actions.move_selection_next,
                            ["<S-TAB>"] = actions.move_selection_previous
                        }
                    }
                }
            })

            require("yanky").setup({})

            require("telescope").load_extension("yank_history")
            require("telescope").load_extension("file_browser")

            local keymap = vim.keymap.set
            local builtin = require("telescope.builtin")

            keymap("n", "<C-p>", builtin.buffers, {})
            keymap("n", "<C-t>", builtin.help_tags, {})
            keymap("n", "<C-g>", builtin.git_bcommits, {})
            keymap("n", "<Leader>f", builtin.live_grep, {})
            keymap("n", "<C-y>", ":Telescope yank_history<CR>", {})
            keymap("n", "<C-f>", ":Telescope file_browser<CR>", {})
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
                theme = "catppuccin",
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
        "dstein64/nvim-scrollview",
        config = function()
            require("scrollview").setup({
                signs_column = 0,
                current_only = true,
                include_end_region = true,
                signs_on_startup = { "conflicts", "diagnostics", "search", "trail" }
            })
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        event = {
            "BufReadPre",
            "BufNewFile"
        },
        config = function()
            require("gitsigns").setup({
                watch_gitdir = {
                    follow_files = true
                },
                attach_to_untracked = true,
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 3000
                }
            })

            local keymap = vim.keymap.set
            keymap("n", "<Leader>gn", ":Gitsigns next_hunk<CR>", { silent = true })
            keymap("n", "<Leader>gp", ":Gitsigns prev_hunk<CR>", { silent = true })
            keymap("n", "<Leader>gg", ":Gitsigns preview_hunk<CR>", { silent = true })
        end
    },
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
    },
    {
        "stevearc/dressing.nvim"
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({})

            local keymap = vim.keymap.set
            keymap("n", "<C-b>", ":NvimTreeToggle<CR>", { silent = true })
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("todo-comments").setup({
                gui_style = {
                    fg = "BOLD",
                    bg = "NONE"
                },
                highlight = {
                    pattern = [[.*<(KEYWORDS)\s*]]
                },
                search = {
                    pattern = [[\b(KEYWORDS)]]
                }
            })
        end
    }
}
