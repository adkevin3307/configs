return {
    {
        "aserowy/tmux.nvim",
        opts = {
            navigation = {
                enable_default_keybindings = false,
            },
            resize = {
                enable_default_keybindings = false,
            },
        },
    },
    {
        "olimorris/persisted.nvim",
        lazy = false,
        opts = {
            use_git_branch = true,
            telescope = {
                mappings = {
                    copy_session = "<A-c>",
                    change_branch = "<A-b>",
                    delete_session = "<A-d>",
                },
            },
        },
        config = function(_, opts)
            local persisted = require("persisted")

            persisted.branch = function()
                local branch = vim.fn.systemlist("git branch --show-current")[1]

                return vim.v.shell_error == 0 and branch or nil
            end

            persisted.setup(opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "PersistedSavePost",
                callback = function()
                    vim.notify("Session saved")
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "PersistedLoadPost",
                callback = function()
                    vim.notify("Session loaded")
                end,
            })
        end,
        keys = {
            { "<Leader>ss", "<CMD>Persisted save<CR>", mode = { "n" }, desc = "Save session" },
        },
    },
    {
        "gbprod/yanky.nvim",
        config = true,
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
            attach_to_untracked = true,
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 3000,
            },
        },
        keys = {
            { "<Leader>gu", "<CMD>Gitsigns reset_hunk<CR>", mode = { "n" }, desc = "Git hunk reset" },
            {
                "<Leader>gn",
                function()
                    require("gitsigns").nav_hunk("next", nil, function()
                        vim.cmd("normal! zz")
                    end)
                end,
                mode = { "n" },
                desc = "Git hunk next",
            },
            {
                "<Leader>gp",
                function()
                    require("gitsigns").nav_hunk("prev", nil, function()
                        vim.cmd("normal! zz")
                    end)
                end,
                mode = { "n" },
                desc = "Git hunk prev",
            },
            { "<Leader>gg", "<CMD>Gitsigns preview_hunk<CR>", mode = { "n" }, desc = "Git hunk preview" },
        },
    },
    {
        "radyz/telescope-gitsigns",
        dependencies = {
            "lewis6991/gitsigns.nvim",
        },
    },
    {
        "niekdomi/conflict.nvim",
        lazy = false,
        opts = {
            default_mappings = {
                current = "<Leader>gxc",
                incoming = "<Leader>gxi",
                both = "<Leader>gxb",
                base = "<Leader>gxB",
                none = "<Leader>gxn",
            },
            disable_diagnostics = false,
        },
        keys = {
            { "<Leader>gc", "<CMD>Conflict list<CR>", mode = { "n" }, desc = "Git conflicts" },
        },
    },
    {
        "kevinhwang91/nvim-hlslens",
        lazy = false,
        dependencies = {
            "haya14busa/vim-asterisk",
        },
        config = true,
        keys = {
            { "*", "<PLUG>(asterisk-z*)<CMD>lua require('hlslens').start()<CR>", mode = { "n", "x" }, desc = "Search" },
            { "#", "<PLUG>(asterisk-z#)<CMD>lua require('hlslens').start()<CR>", mode = { "n", "x" }, desc = "Search" },
            { "g*", "<PLUG>(asterisk-gz*)<CMD>lua require('hlslens').start()<CR>", mode = { "n", "x" }, desc = "Search" },
            { "g#", "<PLUG>(asterisk-gz#)<CMD>lua require('hlslens').start()<CR>", mode = { "n", "x" }, desc = "Search" },
            { "<Leader><ESC>", "<CMD>nohlsearch<CR>", mode = { "n" }, desc = "Disable highlight search" },
        },
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
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "olimorris/persisted.nvim",
            "stevearc/aerial.nvim",
            "gbprod/yanky.nvim",
            "folke/noice.nvim",
            "jemag/telescope-diff.nvim",
            "radyz/telescope-gitsigns",
            "folke/todo-comments.nvim",
            "debugloop/telescope-undo.nvim",
            "linux-cultist/venv-selector.nvim",
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
                            ["<C-h>"] = actions.preview_scrolling_left,
                            ["<C-l>"] = actions.preview_scrolling_right,
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
                extensions = {
                    file_browser = {
                        mappings = {
                            i = {
                                ["<A-h>"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
                                ["<C-h>"] = actions.preview_scrolling_left,
                            },
                        },
                    },
                    undo = {
                        mappings = {
                            i = {
                                ["<cr>"] = require("telescope-undo.actions").restore,
                            },
                        },
                    },
                },
            })

            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("yank_history")
            require("telescope").load_extension("persisted")
            require("telescope").load_extension("aerial")
            require("telescope").load_extension("noice")
            require("telescope").load_extension("diff")
            require("telescope").load_extension("git_signs")
            require("telescope").load_extension("undo")
        end,
        keys = {
            { "<Leader>t*", "*<CMD>Telescope grep_string<CR>", mode = { "n" }, desc = "Telescope grep_string" },
            { "<Leader>tr", "<CMD>Telescope live_grep<CR>", mode = { "n" }, desc = "Telescope live_grep" },
            { "<Leader>to", "<CMD>Telescope aerial<CR>", mode = { "n" }, desc = "Telescope outline" },
            { "<Leader>tn", "<CMD>Telescope notify<CR>", mode = { "n" }, desc = "Telescope notify" },
            { "<Leader>ty", "<CMD>Telescope yank_history<CR>", mode = { "n" }, desc = "Telescope yank_history" },
            { "<Leader>tf", "<CMD>Telescope file_browser path=%:p:h select_buffer=true hidden=true no_ignore=true<CR>", mode = { "n" }, desc = "Telescope file_browser" },
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
            { "<Leader>t\\", "<CMD>Telescope toggleterm_manager<CR>", mode = { "n" }, desc = "Telescope terminal" },
            { "<Leader>tt", "<CMD>TodoTelescope<CR>", mode = { "n" }, desc = "Telescope todo" },
            { "<Leader>tu", "<CMD>Telescope undo<CR>", mode = { "n" }, desc = "Telescope undo" },
            { "<Leader>tv", "<CMD>VenvSelect<CR>", mode = { "n" }, desc = "Telescope venv" },
            { "<Leader>sl", "<CMD>Telescope persisted<CR>", mode = { "n" }, desc = "Load session" },
            { "<Leader>gs", "<CMD>Telescope git_signs<CR>", mode = { "n" }, desc = "Git status" },
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
        "akinsho/toggleterm.nvim",
        opts = {
            open_mapping = "<C-\\>",
            insert_mappings = false,
            direction = "float",
            auto_scroll = false,
        },
        keys = {
            { "<C-\\>", mode = { "n" }, desc = "Toggle terminal" },
        },
    },
    {
        "ryanmsnyder/toggleterm-manager.nvim",
        lazy = true,
        dependencies = {
            "akinsho/toggleterm.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local function create()
                vim.cmd("TermNew")
            end

            local actions = require("toggleterm-manager").actions

            require("toggleterm-manager").setup({
                mappings = {
                    i = {
                        ["<CR>"] = { action = actions.toggle_term, exit_on_action = true },
                        ["<A-c>"] = { action = create, exit_on_action = false },
                        ["<A-d>"] = { action = actions.delete_term, exit_on_action = false },
                        ["<A-r>"] = { action = actions.rename_term, exit_on_action = false },
                        ["<C-i>"] = { action = require("telescope.actions").move_selection_next, exit_on_action = false },
                    },
                },
            })
        end,
    },
    {
        "amitds1997/remote-nvim.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            client_callback = function(port, workspace_config)
                local tmux = os.getenv("TMUX")
                local name = ("editor_%s"):format(workspace_config.host or workspace_config.workspace_id)
                local client = ("%s --server localhost:%s --remote-ui"):format(vim.fn.shellescape(vim.v.progpath), port)
                local cmd = { "tmux", "new-session", "-d", "-s", ("%s_%s"):format(name, port), client }

                if tmux ~= nil and tmux ~= "" then
                    cmd = { "tmux", "new-window", "-n", name, client }
                end

                vim.fn.jobstart(cmd, {
                    detach = true,
                    on_exit = function(_, exit_code)
                        if exit_code ~= 0 then
                            vim.notify(("Failed to start remote client %s, exit code %s"):format(name, exit_code), vim.log.levels.ERROR)
                        elseif cmd[2] == "new-session" then
                            vim.notify(("Remote client started, run `tmux attach -t %s` to use it"):format(cmd[5]))
                        end
                    end,
                })
            end,
        },
        cmd = { "RemoteStart", "RemoteStop", "RemoteInfo", "RemoteCleanup", "RemoteConfigDel", "RemoteLog" },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
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
