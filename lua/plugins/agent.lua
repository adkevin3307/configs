return {
    {
        "avante-corp/avante.nvim",
        build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
        event = "VeryLazy",
        version = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",

            "folke/snacks.nvim",
            "nvim-telescope/telescope.nvim",

            "MeanderingProgrammer/render-markdown.nvim",
            {
                "ColinKennedy/mega.cmdparse",
                dependencies = { "ColinKennedy/mega.logging" },
            },
        },
        opts = {
            provider = "openai",
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

                auto_approve_tool_permissions = false,
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
                select_provider = "<Leader>ap",
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
                selected_files = {
                    height = 10,
                },
                ask = {
                    start_insert = false,
                },
            },
            providers = {
                openai = {
                    endpoint = vim.env.AVANTE_OPENAI_HOST or "http://localhost:11434/v1",
                    api_key_name = vim.env.AVANTE_OPENAI_API_KEY and "AVANTE_OPENAI_API_KEY" or "",
                    use_response_api = false,
                    support_previous_response_id = false,
                },
                claude = {
                    auth_type = "subscription",
                },
            },
        },
        keys = function(_, keys)
            local opts = require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)

            local mappings = {
                {
                    opts.mappings.toggle.default,
                    function()
                        require("avante.api").toggle()
                    end,
                    desc = "avante: toggle",
                    mode = { "n", "v" },
                },
                {
                    opts.mappings.select_provider,
                    "<CMD>AvanteSwitchProvider<CR>",
                    desc = "avante: select provider",
                    mode = { "n" },
                },
                {
                    opts.mappings.select_model,
                    function()
                        require("avante.api").select_model()
                    end,
                    desc = "avante: select model",
                    mode = { "n" },
                },
                {
                    opts.mappings.select_history,
                    function()
                        require("avante.api").select_history()
                    end,
                    desc = "avante: select history",
                    mode = { "n" },
                },
                {
                    opts.mappings.stop,
                    function()
                        require("avante.api").stop()
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
