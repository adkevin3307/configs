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

                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none", fg = "#545b68" },
                    HoverFloat = { bg = "none" },
                    HoverFloatBorder = { bg = "none", fg = "#626262" },

                    ["@spell"] = { fg = "none", bg = "none", sp = "none", fmt = "none" },

                    ["@constructor"] = { fmt = "none" },

                    ["@markup.heading"] = { fmt = "none" },
                    ["@markup.strong"] = { fmt = "none" },
                    ["@markup.italic"] = { fmt = "none" },
                    ["@markup.heading.1"] = { fmt = "none" },
                    ["@markup.heading.2"] = { fmt = "none" },
                    ["@markup.heading.3"] = { fmt = "none" },
                    ["@markup.heading.4"] = { fmt = "none" },
                    ["@markup.heading.5"] = { fmt = "none" },
                    ["@markup.heading.6"] = { fmt = "none" },
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
        "folke/snacks.nvim",
        priority = 1000,
        opts = {
            input = { enabled = true },
            picker = { enabled = true },
            scroll = { enabled = true },
        },
    },
    {
        "rcarriga/nvim-notify",
        opts = {
            background_colour = "#000000",
        },
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            presets = {
                bottom_search = false,
                lsp_doc_border = true,
                command_palette = true,
                long_message_to_split = true,
            },
            messages = {
                view_search = false,
            },
            lsp = {
                signature = {
                    enabled = false,
                },
            },
            views = {
                mini = {
                    win_options = {
                        winblend = 0,
                    },
                },
                hover = {
                    size = {
                        max_height = math.floor(vim.o.lines * 0.6),
                    },
                    win_options = {
                        winblend = 0,
                        winhighlight = {
                            Normal = "HoverFloat",
                            FloatBorder = "HoverFloatBorder",
                        },
                    },
                },
            },
        },
    },
    {
        "akinsho/bufferline.nvim",
        lazy = false,
        priority = 1000,
        dependencies = {
            "navarasu/onedark.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local bufferline = require("bufferline")

            bufferline.setup({
                options = {
                    close_command = "bdelete %d",
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
            "navarasu/onedark.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            options = {
                theme = "auto",
            },
        },
    },
    {
        "Bekaboo/dropbar.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = true,
    },
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")

            require("statuscol").setup({
                relculright = true,
                segments = {
                    { text = { "%s" }, click = "v:lua.ScSa" },
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                },
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = {
                show_start = false,
                show_end = false,
            },
            indent = {
                char = "▏",
            },
        },
    },
    {
        "ntpeters/vim-better-whitespace",
        init = function()
            vim.g.better_whitespace_operator = ""
            vim.g.better_whitespace_guicolor = require("onedark.colors").red
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
    },
}
