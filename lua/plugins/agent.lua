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
            provider = "ollama",
            use_absolute_path = true,
            input = {
                provider = "snacks",
            },
            selector = {
                provider = "telescope",
            },
            providers = {
                ollama = {
                    ["local"] = true,
                    __inherited_from = "openai",
                    endpoint = "http://localhost:11434/v1",
                    model = "qwen3-coder:30b",
                    disable_tools = false,
                    api_key_name = "",
                    is_env_set = function()
                        return true
                    end,
                    extra_request_body = {
                        stream = true,
                    },
                },
                openai = {
                    endpoint = "http://localhost/v1",
                    model = "NVIDIA-Nemotron-3-Ultra-550B-A55B",
                    disable_tools = false,
                    extra_request_body = {
                        stream = true,
                    },
                },
            },
        },
    },
}
