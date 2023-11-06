return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup {
                style = 'dark',
                transparent = true,
                term_colors = true,
                code_style = {
                    comments = "none"
                },
                highlights = {
                    CursorLine = { bg = "none" },
                    CursorLineNR = { fg = "#ff8800" }
                }
            }

            require("onedark").load()
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("lualine").setup {
                options = {
                    theme = "onedark"
                },
                tabline = {
                    lualine_a = { "buffers" }
                }
            }
        end
    }
}
