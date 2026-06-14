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
            provider = "ollamalocal",
            use_absolute_path = true,
            input = {
                provider = "snacks",
                provider_opts = {
                    title = "Avante Input",
                    icon = " ",
                },
            },
            selector = {
                provider = "snacks",
            },
            providers = {
                ollamalocal = {
                    ["local"] = true,
                    __inherited_from = "openai",
                    endpoint = "http://localhost:11434/v1",
                    model = "qwen3-coder:30b",
                    tempature = 0,
                    disable_tools = false,
                    max_tokens = 8192,
                    num_ctx = 32768,
                    api_key_name = "",
                    is_env_set = function()
                        return true
                    end,
                    extra_request_body = {
                        stream = true,
                    },
                },
            },
        },
    },
}
