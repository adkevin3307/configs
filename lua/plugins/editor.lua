return {
    {
        "aserowy/tmux.nvim",
        config = true,
    },
    {
        "adkevin3307/floating-help",
        config = true,
    },
    {
        "gbprod/yanky.nvim",
        config = true,
    },
    {
        "stevearc/aerial.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = true,
    },
    {
        "olimorris/persisted.nvim",
        opts = {
            use_git_branch = true,
        },
        config = function(_, opts)
            local persisted = require("persisted")

            persisted.branch = function()
                local branch = vim.fn.systemlist("git branch --show-current")[1]

                return vim.v.shell_error == 0 and branch or nil
            end

            persisted.setup(opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = { "PersistedSavePost" },
                callback = function()
                    vim.notify("Session saved")
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = { "PersistedLoadPost" },
                callback = function()
                    vim.notify("Session loaded")
                end,
            })
        end,
        keys = {
            { "<Leader>ss", "<CMD>SessionSave<CR>", mode = { "n" }, desc = "Save session" },
        },
    },
    {
        "rcarriga/nvim-notify",
        opts = {
            background_colour = "#000000",
        },
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
            },
            messages = {
                view_search = false,
            },
            lsp = {
                signature = {
                    enabled = false,
                },
            },
            views = {
                mini = {
                    win_options = {
                        winblend = 0,
                    },
                },
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "olimorris/persisted.nvim",
            "stevearc/aerial.nvim",
            "gbprod/yanky.nvim",
            "folke/noice.nvim",
            "jemag/telescope-diff.nvim",
        },
        config = function()
            local actions = require("telescope.actions")

            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<ESC>"] = actions.close,
                            ["<C-q>"] = actions.close,
                            ["<TAB>"] = actions.move_selection_next,
                            ["<S-TAB>"] = actions.move_selection_previous,
                            ["<C-k>"] = actions.preview_scrolling_up,
                            ["<C-j>"] = actions.preview_scrolling_down,
                            ["<C-u>"] = false,
                        },
                    },
                },
                pickers = {
                    git_status = {
                        use_file_path = true,
                    },
                    git_bcommits = {
                        use_file_path = true,
                    },
                },
            })

            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("yank_history")
            require("telescope").load_extension("persisted")
            require("telescope").load_extension("aerial")
            require("telescope").load_extension("noice")
            require("telescope").load_extension("diff")
        end,
        keys = {
            { "<Leader>t*", "*<CMD>Telescope grep_string<CR>", mode = { "n" }, desc = "Telescope grep_string" },
            { "<Leader>tr", "<CMD>Telescope live_grep<CR>", mode = { "n" }, desc = "Telescope live_grep" },
            { "<Leader>tt", "<CMD>Telescope aerial<CR>", mode = { "n" }, desc = "Telescope aerial" },
            { "<Leader>tn", "<CMD>Telescope notify<CR>", mode = { "n" }, desc = "Telescope notify" },
            { "<Leader>ty", "<CMD>Telescope yank_history<CR>", mode = { "n" }, desc = "Telescope yank_history" },
            { "<Leader>tf", "<CMD>Telescope file_browser path=%:p:h select_buffer=true hidden=true<CR>", mode = { "n" }, desc = "Telescope file_browser" },
            {
                "<Leader>tp",
                function()
                    require("telescope.builtin").buffers()
                end,
                mode = { "n" },
                desc = "Telescope buffers",
            },
            {
                "<Leader>td",
                function()
                    require("telescope.builtin").diagnostics({ bufnr = 0 })
                end,
                mode = { "n" },
                desc = "Telescope diagnostics",
            },
            {
                "<Leader>tc",
                function()
                    require("telescope").extensions.diff.diff_current({ hidden = true })
                end,
                mode = { "n" },
                desc = "Telescope diff_current",
            },
            { "<Leader>sl", "<CMD>Telescope persisted<CR>", mode = { "n" }, desc = "Load session" },
            {
                "<Leader>gs",
                function()
                    require("telescope.builtin").git_status()
                end,
                mode = { "n" },
                desc = "Git status",
            },
            {
                "<Leader>gb",
                function()
                    require("telescope.builtin").git_bcommits()
                end,
                mode = { "n" },
                desc = "Git bcommits",
            },
            {
                "<F10>",
                function()
                    require("telescope.builtin").lsp_references()
                end,
                mode = { "n" },
                desc = "LSP references",
            },
            {
                "<F12>",
                function()
                    require("telescope.builtin").lsp_definitions()
                end,
                mode = { "n" },
                desc = "LSP definitions",
            },
        },
    },
    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("barbecue").setup({
                create_autocmd = false,
            })

            vim.api.nvim_create_autocmd({ "WinResized", "BufWinEnter", "CursorHold", "InsertLeave" }, {
                group = vim.api.nvim_create_augroup("barbecue.updater", {}),
                callback = function()
                    require("barbecue.ui").update()
                end,
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        opts = {
            signs = {
                add = { text = " │" },
                change = { text = " │" },
                delete = { text = " │" },
                topdelete = { text = " │" },
                changedelete = { text = " │" },
                untracked = { text = " │" },
            },
            watch_gitdir = {
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 3000,
            },
        },
        keys = {
            { "<Leader>gn", "<CMD>Gitsigns next_hunk<CR>zz", mode = { "n" }, desc = "Git hunk next" },
            { "<Leader>gp", "<CMD>Gitsigns prev_hunk<CR>zz", mode = { "n" }, desc = "Git hunk prev" },
            { "<Leader>gg", "<CMD>Gitsigns preview_hunk<CR>", mode = { "n" }, desc = "Git hunk preview" },
        },
    },
    {
        "ntpeters/vim-better-whitespace",
        init = function()
            vim.g.better_whitespace_operator = ""

            vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = require("onedark.colors").red })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = {
                show_start = false,
                show_end = false,
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = { "c", "cpp", "lua", "vim", "bash", "yaml", "regex", "vimdoc", "python", "markdown" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
    },
    {
        "numToStr/Comment.nvim",
        opts = {
            ignore = "^$",
            toggler = {
                line = "<Leader>cc",
            },
            opleader = {
                line = "<Leader>cc",
            },
            mapping = {
                basic = false,
                extra = false,
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<Space><Space>", "<CMD>Neotree toggle<CR>", mode = { "n" }, desc = "Neotree toggle" },
        },
    },
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")

            require("statuscol").setup({
                relculright = true,
                segments = {
                    { text = { "%s" }, click = "v:lua.ScSa" },
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                },
            })
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            "nvim-treesitter/nvim-treesitter",
            "luukvbaal/statuscol.nvim",
        },
        opts = {
            provider_selector = function()
                return { "treesitter", "indent" }
            end,
        },
    },
    {
        "kevinhwang91/nvim-hlslens",
        lazy = false,
        config = true,
        keys = {
            { "*", "<CMD>let @/= '\\<' . expand('<cword>') . '\\>' <BAR> set hlsearch <CR><CMD>lua require('hlslens').start()<CR>", mode = { "n" }, desc = "Search" },
            { "<C-n>", "<CMD>nohlsearch<CR>", mode = { "n" }, desc = "Turn off matched highlight" },
        },
    },
    {
        "lewis6991/satellite.nvim",
        opts = {
            winblend = 0,
            handlers = {
                cursor = {
                    enable = false,
                },
            },
        },
    },
    {
        "akinsho/toggleterm.nvim",
        opts = {
            open_mapping = "<Leader>\\",
            insert_mappings = false,
            direction = "float",
        },
    },
    {
        "RRethy/vim-illuminate",
        lazy = false,
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrids = {
                providers = { "lsp" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
        keys = {
            {
                "<Leader>cn",
                function()
                    require("illuminate").goto_next_reference()
                end,
                mode = { "n" },
                desc = "Next hover word",
            },
            {
                "<Leader>cp",
                function()
                    require("illuminate").goto_prev_reference()
                end,
                mode = { "n" },
                desc = "Prev hover word",
            },
        },
    },
    {
        "linux-cultist/venv-selector.nvim",
        event = "VeryLazy",
        branch = "regexp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            settings = {
                options = {
                    enable_cached_venvs = false,
                    cached_venv_automatic_activation = false,
                    notify_user_on_venv_activation = true,
                },
            },
        },
    },
    {
        "amitds1997/remote-nvim.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            client_callback = function(port, workspace_config)
                local tmux = os.getenv("TMUX")
                local cmd = ("tmux new-session -d -s 'editor_%s' 'nvim --server localhost:%s --remote-ui'"):format(workspace_config.host, port)

                if tmux ~= nil and tmux ~= "" then
                    cmd = ("tmux new-window -d -n editor_%s 'nvim --server localhost:%s --remote-ui'"):format(workspace_config.host, port)
                end

                vim.fn.jobstart(cmd, {
                    detach = true,
                    on_exit = function(job_id, exit_code, event_type)
                        print("Client", job_id, "exited with code", exit_code, "Event type:", event_type)
                    end,
                })
            end,
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            defaults = {},
            keys = {
                scroll_up = "<C-k>",
                scroll_down = "<C-j>",
            },
            spec = {
                { "<Leader>g", group = "git" },
                { "<Leader>c", group = "code" },
                { "<Leader>b", group = "buffer" },
                { "<Leader>s", group = "session" },
                { "<Leader>t", group = "telescope" },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ loop = true })
                end,
                mode = { "n" },
                desc = "Help",
            },
        },
    },
}
