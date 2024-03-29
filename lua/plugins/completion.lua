return {
    {
        "neovim/nvim-lspconfig",
        event = {
            "BufReadPre",
            "BufNewFile"
        },
        dependencies = {
            {
                "williamboman/mason.nvim",
                config = function()
                    require("mason").setup({})
                end
            },
            {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                    require("mason-lspconfig").setup({
                        ensure_installed = { "clangd", "yamlls", "jsonls", "bashls", "lua_ls", "pyright" },
                        automatic_installation = true
                    })
                end
            }
        },
        config = function()
            require("lspconfig").clangd.setup({})
            require("lspconfig").yamlls.setup({})
            require("lspconfig").jsonls.setup({})
            require("lspconfig").bashls.setup({})
            require("lspconfig").lua_ls.setup({})
            require("lspconfig").pyright.setup({})

            vim.diagnostic.config({
                virtual_text = false
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local keymap = vim.keymap.set
                    local opts = { buffer = ev.buf }

                    keymap("n", "<F12>", vim.lsp.buf.definition, opts)
                    keymap("n", "<F2>", vim.lsp.buf.rename, opts)
                    keymap("n", "?", vim.lsp.buf.hover, opts)
                end
            })

            vim.api.nvim_create_autocmd("CursorHold", {
                buffer = bufnr,
                callback = function()
                    local opts = {
                        focusable = false,
                        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                        border = "single",
                        source = "always",
                        prefix = "",
                        scope = "cursor",
                    }

                    vim.diagnostic.open_float(nil, opts)
                end
            })

            for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
                vim.fn.sign_define("DiagnosticSign" .. diag, {
                    text = "",
                    texthl = "DiagnosticSign" .. diag,
                    linehl = "",
                    numhl = "DiagnosticSign" .. diag
                })
            end
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",

            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip"
        },
        config = function()
            local has_words_before = function()
                unpack = unpack or table.unpack

                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone.preview.noselect"
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                mapping = {
                    ["<TAB>"] = function(fallback)
                        if not cmp.select_next_item() then
                            if vim.bo.buftype ~= "prompt" and has_words_before() then
                                cmp.complete_common_string()
                            else
                                fallback()
                            end
                        end
                    end,
                    ["<S-TAB>"] = function(fallback)
                        if not cmp.select_prev_item() then
                            if vim.bo.buftype ~= "prompt" and has_words_before() then
                                cmp.complete_common_string()
                            else
                                fallback()
                            end
                        end
                    end,
                    ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "s" }),
                    ["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "s" }),
                    ["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "s" })
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" }
                }
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("lspconfig").clangd.setup({ capabilities = capabilities })
            require("lspconfig").yamlls.setup({ capabilities = capabilities })
            require("lspconfig").jsonls.setup({ capabilities = capabilities })
            require("lspconfig").bashls.setup({ capabilities = capabilities })
            require("lspconfig").lua_ls.setup({ capabilities = capabilities })
            require("lspconfig").pyright.setup({ capabilities = capabilities })
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup({})
        end
    }
}
