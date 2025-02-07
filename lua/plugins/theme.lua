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
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
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
                    local symbol = { ["error"] = " ", ["warning"] = " ", ["info"] = " ", ["hint"] = " " }

                    for _, diagnostic in ipairs({ "error", "warning", "info", "hint" }) do
                        if diagnostics_dict[diagnostic] then
                            s = " " .. s .. diagnostics_dict[diagnostic] .. symbol[diagnostic]
                        end
                    end

                    return s
                end,

                separator_style = { "", "" },
                sort_by = "insert_at_end",
            },
        },
        keys = {
            { "<Tab>", "<CMD>BufferLineCycleNext<CR>", mode = { "n" }, desc = "Next buffer" },
            { "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>", mode = { "n" }, desc = "Prev buffer" },
            { "<Leader>bn", "<CMD>BufferLineMoveNext<CR>", mode = { "n" }, desc = "Move buffer next" },
            { "<Leader>bp", "<CMD>BufferLineMovePrev<CR>", mode = { "n" }, desc = "Move buffer prev" },
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
