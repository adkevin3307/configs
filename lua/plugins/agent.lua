return {
    {
        "yetone/avante.nvim",
        build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
        event = "VeryLazy",
        version = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",

            "folke/snacks.nvim",
            "nvim-telescope/telescope.nvim",

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
            selection = {
                enabled = false,
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
                select_model = "<Leader>am",
                select_history = "<Leader>ah",
                stop = "<Leader>ac",
            },
            windows = {
                sidebar_header = {
                    align = "right",
                    include_model = true,
                },
                input = {
                    prefix = "",
                    height = 25,
                },
                seleced_files = {
                    height = 10,
                },
                ask = {
                    start_insert = false,
                },
            },
            providers = {
                openai = {
                    endpoint = vim.env.AVANTE_OPENAI_HOST or "http://localhost:11434/v1",
                    api_key_name = vim.env.AVANTE_OPENAI_API_KEY and "OPENAI_API_KEY" or "",
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
                {
                    opts.mappings.select_history,
                    function()
                        avante.select_history()
                    end,
                    desc = "avante: select history",
                    mode = { "n" },
                },
                {
                    opts.mappings.stop,
                    function()
                        avante.stop()
                    end,
                    desc = "avante: stop",
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
