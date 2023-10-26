return {
    {
        "williamboman/mason.nvim",
        priority = 100,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        priority = 90,
    },
    {
        "neovim/nvim-lspconfig",
        priority = 80,
        config = function()
            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "pyright", "yamlls", "jsonls", "bashls", "lua_ls" },
                automatic_installation = true
            })

            require("lspconfig").clangd.setup({})
            require("lspconfig").pyright.setup({})
            require("lspconfig").yamlls.setup({})
            require("lspconfig").jsonls.setup({})
            require("lspconfig").bashls.setup({})
            require("lspconfig").lua_ls.setup({})

            vim.diagnostic.config({
                virtual_text = false
            })
        end
    },

    {
        "neoclide/coc.nvim",
        branch = "master",
        build = "npm ci",
        config = function()
            vim.g.coc_global_extensions = { "coc-clangd", "coc-pyright", "coc-sh", "coc-cmake", "coc-json", "coc-yaml", "coc-lua" }

            local keymap = vim.keymap.set

            function _G.check_back_space()
                local col = vim.fn.col(".") - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
            end

            local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
            keymap("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
            keymap("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

            function _G.show_docs()
                local cw = vim.fn.expand("<cword>")
                if vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
                    vim.api.nvim_command("h " .. cw)
                elseif vim.api.nvim_eval("coc#rpc#ready()") then
                    vim.fn.CocActionAsync("doHover")
                else
                    vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
                end
            end

            keymap("n", "?", "<CMD>lua _G.show_docs()<CR>", { silent = true })

            keymap("n", "<F2>", "<Plug>(coc-rename)", { silent = true })
            keymap("n", "<F12>", "<Plug>(coc-definition)", { silent = true })

            local opts = { silent = true, nowait = true, expr = true }
            keymap("n", "<C-j>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<Down>"', opts)
            keymap("n", "<C-k>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<Up>"', opts)
            keymap("i", "<C-j>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Down>"', opts)
            keymap("i", "<C-k>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Up>"', opts)
            keymap("v", "<C-j>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<Down>"', opts)
            keymap("v", "<C-k>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<Up>"', opts)
        end
    }
}
