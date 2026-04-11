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
            ensure_installed = { "c", "cpp", "lua", "vim", "bash", "yaml", "regex", "vimdoc", "python", "markdown", "vue", "html", "css", "javascript", "dockerfile" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
    },
    {
        "ray-x/lsp_signature.nvim",
        opts = {
            hint_prefix = {
                above = "↙ ",
                current = "← ",
                below = "↖ ",
            },
        },
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

            vim.diagnostic.config({ virtual_text = false })
        end,
        keys = {
            { "<F3>", "<CMD>TinyInlineDiag toggle<CR>", mode = { "n" }, desc = "Toggle diagnostic" },
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
        "hrsh7th/nvim-cmp",
        dependencies = {
            "folke/lazydev.nvim",

            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local has_words_before = function()
                local unpack = unpack or table.unpack

                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = {
                    ["<TAB>"] = function(fallback)
                        if not cmp.select_next_item() then
                            if vim.bo.buftype ~= "prompt" and has_words_before() then
                                cmp.complete()
                            else
                                fallback()
                            end
                        end
                    end,
                    ["<S-TAB>"] = function(fallback)
                        if not cmp.select_prev_item() then
                            if vim.bo.buftype ~= "prompt" and has_words_before() then
                                cmp.complete()
                            else
                                fallback()
                            end
                        end
                    end,
                    ["<C-j>"] = cmp.mapping.scroll_docs(4),
                    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                },
                sources = {
                    { name = "lazydev" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "buffer" },
                    { name = "path" },
                },
            })
        end,
    },
    {
        "mason-org/mason.nvim",
        config = true,
    },
    {
        "stevearc/conform.nvim",
        opts = {
            default_format_ops = {
                timeout_ms = 5000,
            },
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
        "zapling/mason-conform.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "stevearc/conform.nvim",
        },
        config = true,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            vim.lsp.config("ts_ls", {
                filetypes = { "typescript", "javascript", "vue" },
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspance = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                    },
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local keymap = vim.keymap.set

                    keymap("n", "<F2>", vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP rename" })
                    keymap("n", "?", vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP hover" })

                    keymap("n", "K", "", { buffer = ev.buf })
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
            ensure_installed = { "clangd", "yamlls", "jsonls", "bashls", "lua_ls", "pyright", "ruff", "ts_ls", "vue_ls" },
            automatic_enable = true,
        },
    },
}
