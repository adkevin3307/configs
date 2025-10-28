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
                    CursorLineNR = { fg = "#ff8800", fmt = "none" },

                    ["@constructor"] = { fmt = "none" },

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

                    cppStatement = { fmt = "none" },
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
