return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
    },
    {
        "MeanderingProgrammer/treesitter-modules.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            ensure_installed = { "c", "cpp", "lua", "vim", "bash", "yaml", "regex", "vimdoc", "python", "markdown", "vue", "html", "css", "javascript", "typescript", "dockerfile" },
            auto_install = true,
            highlight = {
                enable = true,
            },
        },
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                height = 0.8,
                border = "rounded",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "mason",
                callback = function()
                    vim.opt_local.cursorline = false
                end,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    vim.keymap.set("n", "?", vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP hover" })
                    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP rename" })

                    vim.keymap.set("n", "K", "", { buffer = ev.buf })
                    vim.keymap.del("n", "K", { buffer = ev.buf })
                end,
            })

            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.INFO] = "",
                        [vim.diagnostic.severity.HINT] = "",
                    },
                    linehl = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.INFO] = "",
                        [vim.diagnostic.severity.HINT] = "",
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                    },
                },
            })
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = { "clangd", "yamlls", "jsonls", "bashls", "lua_ls", "pyright", "ruff", "ts_ls" },
            automatic_enable = {
                exclude = { "stylua" },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                sh = { "shfmt" },
                lua = { "stylua" },
                json = { "prettier" },
                yaml = { "yamlfmt" },
                python = { "black" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                vue = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                nginx = { "nginxfmt" },
                ["_"] = { "trim_whitespace" },
            },
            formatters = {
                stylua = {
                    prepend_args = { "--column-width", "250", "--indent-type", "Spaces" },
                },
                black = {
                    prepend_args = { "--line-length", "250", "--skip-string-normalization" },
                },
                prettier = {
                    prepend_args = { "--print-width", "250", "--tab-width", "4", "--vue-indent-script-and-style", "true" },
                },
                yamlfmt = {
                    prepend_args = { "-formatter", "retain_line_breaks_single=true" },
                },
            },
        },
        keys = {
            {
                "<F4>",
                function()
                    require("conform").format({ async = true })
                end,
                mode = { "n", "v" },
                desc = "LSP format",
            },
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "mason-org/mason.nvim",
        },
        opts = {
            ensure_installed = { "shfmt", "stylua", "prettier", "yamlfmt", "black", "clang-format", "nginx-config-formatter" },
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                {
                    path = "${3rd}/luv/library",
                    words = { "vim%.uv" },
                },
            },
        },
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            "saghen/blink.lib",

            "folke/lazydev.nvim",
            "folke/noice.nvim",

            "rafamadriz/friendly-snippets",
            "Kaiser-Yang/blink-cmp-avante",
        },
        build = function()
            require("blink.cmp").build():pwait()
        end,
        opts = {
            keymap = {
                preset = "none",
                ["<TAB>"] = {
                    function(cmp)
                        local has_words_before = function()
                            local unpack = unpack or table.unpack
                            local line, col = unpack(vim.api.nvim_win_get_cursor(0))

                            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
                        end

                        if not cmp.is_visible() and has_words_before() then
                            return cmp.show()
                        end

                        return cmp.select_next()
                    end,
                    "fallback",
                },
                ["<S-TAB>"] = {
                    function(cmp)
                        local has_words_before = function()
                            local unpack = unpack or table.unpack
                            local line, col = unpack(vim.api.nvim_win_get_cursor(0))

                            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
                        end

                        if not cmp.is_visible() and has_words_before() then
                            return cmp.show()
                        end

                        return cmp.select_prev()
                    end,
                    "fallback",
                },
                ["<CR>"] = { "accept", "fallback" },
                ["<C-j>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },
                ["<C-k>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
                ["<C-n>"] = { "snippet_forward", "fallback" },
                ["<C-p>"] = { "snippet_backward", "fallback" },
                ["<C-e>"] = { "hide", "hide_signature", "fallback" },
            },
            completion = {
                list = {
                    selection = {
                        preselect = false,
                    },
                },
                menu = {
                    border = "rounded",
                    max_height = vim.o.lines + 1,
                    draw = {
                        columns = {
                            { "kind_icon" },
                            { "label", "label_description", gap = 1 },
                            { "kind" },
                            { "source_id" },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 10,
                    window = {
                        border = "rounded",
                        max_height = math.floor(vim.o.lines * 0.6),
                    },
                },
            },
            signature = {
                enabled = true,
                trigger = {
                    show_on_insert = true,
                    show_on_keyword = true,
                },
                window = {
                    border = "rounded",
                    max_height = math.floor(vim.o.lines * 0.6),
                    show_documentation = true,
                },
            },
            cmdline = {
                enabled = false,
            },
            term = {
                enabled = false,
            },
            sources = {
                default = { "lazydev", "avante", "lsp", "path", "buffer", "snippets" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    avante = {
                        module = "blink-cmp-avante",
                        name = "Avante",
                    },
                },
            },
        },
        config = function(_, opts)
            local cmp = require("blink.cmp")

            cmp.setup(opts)

            local function highlight()
                vim.api.nvim_set_hl(0, "BlinkCmpLabel", { bg = "none" })
                vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { bg = "none" })
                vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { bg = "none", fg = "#5f5f5f" })

                vim.api.nvim_set_hl(0, "BlinkCmpSource", { bg = "none", fg = "#5f5f5f" })

                vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "none" })
                vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "none", fg = "#626262" })

                vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "none" })
                vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = "none", fg = "#626262" })
                vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { bg = "none", fg = "#626262" })

                vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = "none" })
                vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = "none", fg = "#626262" })
            end

            highlight()

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "*",
                callback = highlight,
            })

            vim.api.nvim_create_autocmd("CursorMovedI", {
                pattern = "*",
                callback = function()
                    if not cmp.is_signature_visible() then
                        cmp.show_signature()
                    end
                end,
            })
        end,
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        lazy = false,
        config = function()
            require("tiny-inline-diagnostic").setup({
                options = {
                    show_diags_only_under_cursor = true,
                    show_source = {
                        enabled = true,
                    },
                },
            })
        end,
        keys = {
            { "<F3>", "<CMD>TinyInlineDiag toggle<CR>", mode = { "n" }, desc = "Toggle diagnostic" },
        },
    },
    {
        "RRethy/vim-illuminate",
        lazy = false,
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                delay = 200,
                providers = { "lsp" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
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
        "numToStr/Comment.nvim",
        opts = {
            ignore = "^$",
            mappings = false,
        },
        keys = {
            { "<Leader>cc", "<Plug>(comment_toggle_linewise_current)", mode = { "n" }, desc = "Comment toggle" },
            { "<Leader>cc", "<Plug>(comment_toggle_linewise_visual)", mode = { "x" }, desc = "Comment toggle" },
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            signs = false,
        },
    },
    {
        "linux-cultist/venv-selector.nvim",
        opts = {
            options = {
                enable_cached_venvs = false,
                cached_venv_automatic_activation = false,
                notify_user_on_venv_activation = true,
                override_notify = false,
            },
            search = {
                uv = {
                    command = "fd /bin/python$ ~/.cache/uv/virtualenvs --full-path",
                },
            },
        },
        cmd = { "VenvSelect" },
    },
}
