return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup({
                style = "dark",
                transparent = true,
                term_colors = false,
                code_style = {
                    comments = "none",
                },
                highlights = {
                    CursorLineNR = { fg = "#ff8800", fmt = "none" },

                    ["@constructor"] = { fmt = "none" },

                    ["@markup.heading"] = { fmt = "none" },
                    ["@markup.strong"] = { fmt = "none" },
                    ["@markup.heading.1.markdown"] = { fmt = "none" },
                    ["@markup.heading.2.markdown"] = { fmt = "none" },
                    ["@markup.heading.3.markdown"] = { fmt = "none" },
                    ["@markup.heading.4.markdown"] = { fmt = "none" },
                    ["@markup.heading.5.markdown"] = { fmt = "none" },
                    ["@markup.heading.6.markdown"] = { fmt = "none" },
                    ["@markup.heading.1.marker.markdown"] = { fmt = "none" },
                    ["@markup.heading.2.marker.markdown"] = { fmt = "none" },
                    ["@markup.heading.3.marker.markdown"] = { fmt = "none" },
                    ["@markup.heading.4.marker.markdown"] = { fmt = "none" },
                    ["@markup.heading.5.marker.markdown"] = { fmt = "none" },
                    ["@markup.heading.6.marker.markdown"] = { fmt = "none" },

                    ["@text.strong"] = { fmt = "none" },
                    ["@text.title"] = { fmt = "none" },

                    NeoTreeRootName = { fmt = "none" },
                    NeoTreeGitConflict = { fmt = "none" },
                    NeoTreeGitUntracked = { fmt = "none" },

                    illuminatedWord = { fmt = "none" },
                    illuminatedCurWord = { fmt = "none" },
                    IlluminatedWordText = { fmt = "none" },
                    IlluminatedWordRead = { fmt = "none" },
                    IlluminatedWordWrite = { fmt = "none" },

                    ErrorMsg = { fmt = "none" },
                    WarningMsg = { fmt = "none" },
                    MoreMsg = { fmt = "none" },

                    TelescopeMatching = { fmt = "none" },

                    SnacksDashboardFooter = { fmt = "none" },
                    SnacksDashboardSpecial = { fmt = "none" },
                    SnacksPickerMatch = { fmt = "none" },

                    FocusedSymbol = { fmt = "none" },
                    AerialLine = { fmt = "none" },

                    cppStatement = { fmt = "none" },

                    markdownH1 = { fmt = "none" },
                    markdownH2 = { fmt = "none" },
                    markdownH3 = { fmt = "none" },
                    markdownH4 = { fmt = "none" },
                    markdownH5 = { fmt = "none" },
                    markdownH6 = { fmt = "none" },

                    IblScope = { fg = "#848b98", fmt = "nocombine" },
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
        config = function()
            local bufferline = require("bufferline")

            bufferline.setup({
                options = {
                    left_mouse_command = "buffer %d",
                    right_mouse_command = "buffer %d",
                    middle_mouse_command = "bdelete %d",

                    indicator = {
                        style = "underline",
                    },

                    style_preset = {
                        bufferline.style_preset.no_bold,
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
            })
        end,
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
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "navarasu/onedark.nvim",
        },
        config = function()
            local c = require("onedark.colors")
            local cfg = vim.g.onedark_config

            local colors = {
                bg = c.bg0,
                fg = c.fg,
                red = c.red,
                green = c.green,
                yellow = c.yellow,
                blue = c.blue,
                purple = c.purple,
                cyan = c.cyan,
                gray = c.grey,
            }

            local onedark = {
                inactive = {
                    a = { fg = colors.gray, bg = colors.bg },
                    b = { fg = colors.gray, bg = colors.bg },
                    c = { fg = colors.gray, bg = cfg.lualine.transparent and c.none or c.bg1 },
                },
                normal = {
                    a = { fg = colors.bg, bg = colors.green },
                    b = { fg = colors.fg, bg = c.bg3 },
                    c = { fg = colors.fg, bg = cfg.lualine.transparent and c.none or c.bg1 },
                },
                visual = { a = { fg = colors.bg, bg = colors.purple } },
                replace = { a = { fg = colors.bg, bg = colors.red } },
                insert = { a = { fg = colors.bg, bg = colors.blue } },
                command = { a = { fg = colors.bg, bg = colors.yellow } },
                terminal = { a = { fg = colors.bg, bg = colors.cyan } },
            }

            require("lualine").setup({ options = { theme = onedark } })
        end,
    },
}
