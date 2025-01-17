return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            {
                "gbprod/yanky.nvim",
                config = function()
                    require("yanky").setup({})
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
                "folke/noice.nvim",
                dependencies = {
                    "MunifTanjim/nui.nvim",
                    {
                        "rcarriga/nvim-notify",
                        config = function()
                            require("notify").setup({
                                background_colour = "#000000"
                            })
                        end
                    }
                },
                opts = {
                    presets = {
                        bottom_search = false,
                        command_palette = true,
                        long_message_to_split = true
                    },
                    messages = {
                        view_search = false
                    },
                    lsp = {
                        signature = {
                            enabled = false
                        }
                    },
                    views = {
                        mini = {
                            win_options = {
                                winblend = 0
                            }
                        }
                    }
                }
            },
            "jemag/telescope-diff.nvim"
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
                },
                pickers = {
                    git_status = {
                        use_file_path = true
                    },
                    git_bcommits = {
                        use_file_path = true
                    }
                }
            })

            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("yank_history")
            require("telescope").load_extension("aerial")
            require("telescope").load_extension("noice")
            require("telescope").load_extension("diff")

            local keymap = vim.keymap.set
            local builtin = require("telescope.builtin")

            keymap("n", "<Leader>.", "*:Telescope grep_string<CR>", {})
            keymap("n", "<Leader>r", ":Telescope live_grep<CR>", {})
            keymap("n", "<Leader>d", function() require("telescope").extensions.diff.diff_current({ hidden = true }) end, {})

            keymap("n", "<F10>", builtin.lsp_references, {})
            keymap("n", "<F12>", builtin.lsp_definitions, {})
            keymap("n", "<C-p>", builtin.buffers, {})
            keymap("n", "<C-s>", builtin.git_status, {})
            keymap("n", "<C-g>", builtin.git_bcommits, {})
            keymap("n", "<C-n>", ":Telescope notify<CR>", {})
            keymap("n", "<C-t>", ":Telescope aerial<CR>", {})
            keymap("n", "<C-y>", ":Telescope yank_history<CR>", {})
            keymap("n", "<C-f>", ":Telescope file_browser path=%:p:h select_buffer=true hidden=true<CR>", {})
            keymap("n", "<C-d>", function() builtin.diagnostics({ bufnr = 0 }) end, {})
        end
    },
    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons"
        },
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
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "cpp", "lua", "vim", "bash", "yaml", "regex", "vimdoc", "python", "markdown" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                }
            })
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
            keymap("n", "<Space><Space>", ":NvimTreeToggle<CR>", { silent = true })
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        opts = {
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
        }
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
        opts = {
            provider_selector = function()
                return { "treesitter", "indent" }
            end
        }
    },
    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("hlslens").setup({})
        end
    },
    {
        "lewis6991/satellite.nvim",
        opts = {
            winblend = 0,
            handlers = {
                cursor = {
                    enable = false
                }
            }
        }
    },
    {
        "aserowy/tmux.nvim"
    },
    {
        "amitds1997/remote-nvim.nvim",
        version = "v0.3.9",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("remote-nvim").setup({
                client_callback = function(port, workspace_config)
                    local tmux = os.getenv("TMUX")
                    local cmd = ("tmux new-session -d -s 'editor_%s' 'nvim --server localhost:%s --remote-ui'"):format(workspace_config.host, port)

                    if tmux ~= nil and tmux ~= '' then
                        cmd = ("tmux new-window -d -n editor_%s 'nvim --server localhost:%s --remote-ui'"):format(workspace_config.host, port)
                    end

                    vim.fn.jobstart(cmd, {
                        detach = true,
                        on_exit = function(job_id, exit_code, event_type)
                            print("Client", job_id, "exited with code", exit_code, "Event type:", event_type)
                        end,
                    })
                end,
            })
        end
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require('toggleterm').setup({
                open_mapping = '<C-\\>',
                direction = 'float'
            })
        end
    }
}
