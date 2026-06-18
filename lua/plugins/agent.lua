return {
    {
        "yetone/avante.nvim",
        build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
        event = "VeryLazy",
        version = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",

            "nvim-telescope/telescope.nvim",
            "folke/snacks.nvim",

            "nvim-tree/nvim-web-devicons",
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
        opts = {
            provider = "openai",
            use_absolute_path = true,
            input = {
                provider = "snacks",
            },
            selector = {
                provider = "telescope",
            },
            behaviour = {
                auto_set_keymaps = false,
                jump_result_buffer_on_finish = true,

                confirmation_ui_style = "popup",
            },
            prompt_logger = {
                next_prompt = {
                    normal = "<C-Down>",
                    insert = "<C-Down>",
                },
                prev_prompt = {
                    normal = "<C-Up>",
                    insert = "<C-Up>",
                },
            },
            mappings = {
                toggle = {
                    default = "<Leader>at",
                },
                submit = {
                    normal = "<C-s>",
                    insert = "<C-s>",
                },
                select_model = "<Leader>a?",
            },
            windows = {
                sidebar_header = {
                    align = "right",
                    include_model = true,
                },
                input = {
                    prefix = "",
                    height = 20,
                },
                ask = {
                    start_insert = false,
                },
            },
            providers = {
                openai = {
                    endpoint = vim.env.OPENAI_HOST or "http://localhost:11434/v1",
                    disable_tools = false,
                    extra_request_body = {
                        stream = true,
                    },
                },
            },
        },
        keys = function(_, keys)
            local avante = require("avante.api")
            local opts = require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)

            local mappings = {
                {
                    opts.mappings.toggle.default,
                    function()
                        avante.toggle()
                    end,
                    desc = "avante: toggle",
                    mode = { "n", "v" },
                },
                {
                    opts.mappings.select_model,
                    function()
                        avante.select_model()
                    end,
                    desc = "avante: select model",
                    mode = { "n" },
                },
            }

            mappings = vim.tbl_filter(function(m)
                return m[1] and #m[1] > 0
            end, mappings)

            return vim.list_extend(mappings, keys)
        end,
    },
}
