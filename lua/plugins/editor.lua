return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",

            "gbprod/yanky.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "stevearc/aerial.nvim"
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
            require("telescope").load_extension("aerial")

            local keymap = vim.keymap.set
            local builtin = require("telescope.builtin")

            keymap("n", "<C-p>", builtin.buffers, {})
            keymap("n", "<C-s>", builtin.git_status, {})
            keymap("n", "<C-g>", builtin.git_bcommits, {})
            keymap("n", "<C-t>", ":Telescope aerial<CR>", {})
            keymap("n", "<C-y>", ":Telescope yank_history<CR>", {})
            keymap("n", "<C-f>", ":Telescope file_browser path=%:p:h select_buffer=true hidden=true<CR>", {})
            keymap("n", "<C-d>", function() builtin.diagnostics({ bufnr = 0 }) end, {})
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
        event = {
            "BufReadPre",
            "BufNewFile"
        },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = ' │' },
                    change       = { text = ' │' },
                    delete       = { text = ' │' },
                    topdelete    = { text = ' │' },
                    changedelete = { text = ' │' },
                    untracked    = { text = ' │' },
                },
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
            require("ibl").setup({
                scope = {
                    show_start = false,
                    show_end = false
                }
            })
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
            ignore = "^$",
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
    },
    {
        "AckslD/muren.nvim",
        config = function()
            require("muren").setup({
                keys = {
                    close = "<ESC>"
                },
                patterns_width = 40,
                patterns_height = 20,
                options_width = 40,
                options_height = 20,
                preview_height = 30
            })

            local keymap = vim.keymap.set
            keymap("n", "<F3>", ":MurenToggle<CR>", { silent = true })
        end
    },
    {
        "stevearc/aerial.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("aerial").setup({})
        end
    },
    {
        "gorbit99/codewindow.nvim",
        config = function()
            require("codewindow").setup({
                z_index = 10,
                auto_enable = true,
                show_cursor = false,
                screen_bounds = "background",
                window_border = "none"
            })

            vim.api.nvim_set_hl(0, "CodewindowBoundsBackground", { bg = require("onedark.colors").grey })
        end
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            "nvim-treesitter/nvim-treesitter",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require("statuscol.builtin")
                    require("statuscol").setup({
                        relculright = true,
                        segments = {
                            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                            { text = { "%s" }, click = "v:lua.ScSa" },
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                        },
                    })
                end,
            },
        },
        event = "BufReadPost",
        opts = {
            provider_selector = function()
                return { "treesitter", "indent" }
            end,
        }
    }
}
