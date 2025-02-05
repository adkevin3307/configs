return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup({
                style = "dark",
                transparent = true,
                term_colors = true,
                code_style = {
                    comments = "none",
                },
                highlights = {
                    CursorLineNR = { fg = "#ff8800" },
                },
            })

            require("onedark").load()
        end,
    },
    {
        "akinsho/bufferline.nvim",
        lazy = false,
        priority = 1000,
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            options = {
                left_mouse_command = "buffer %d",
                right_mouse_command = "buffer %d",
                middle_mouse_command = "bdelete %d",

                indicator = {
                    style = "underline",
                },

                diagnostics = "nvim_lsp",
                always_show_bufferline = true,
                diagnostics_indicator = function(_, _, diagnostics_dict)
                    local s = ""

                    for diagnostic, symbol in pairs({ ["error"] = " ", ["warning"] = " ", ["info"] = " " }) do
                        if diagnostics_dict[diagnostic] then
                            s = " " .. s .. symbol .. diagnostics_dict[diagnostic]
                        end
                    end

                    return s
                end,

                separator_style = { "", "" },
                sort_by = "insert_after_current",
            },
        },
        keys = {
            { "<Tab>", "<CMD>BufferLineCycleNext<CR>", mode = { "n" } },
            { "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>", mode = { "n" } },
            { "<Leader>bn", "<CMD>BufferLineMoveNext<CR>", mode = { "n" } },
            { "<Leader>bp", "<CMD>BufferLineMovePrev<CR>", mode = { "n" } },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            options = {
                theme = "onedark",
            },
        },
    },
}
