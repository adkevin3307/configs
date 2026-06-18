return {
    {
        "yetone/avante.nvim",
        enabled = false,
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
                    endpoint = "",
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
                    endpoint = "",
                    model = "NVIDIA-Nemotron-3-Ultra-550B-A55B",
                    disable_tools = false,
                    extra_request_body = {
                        stream = true,
                    },
                },
            },
        },
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",

            "ravitemer/mcphub.nvim",
            {
                "MeanderingProgrammer/render-markdown.nvim",
                ft = { "markdown", "codecompanion" },
            },
            {
                "HakonHarnes/img-clip.nvim",
                opts = {
                    filetypes = {
                        codecompanion = {
                            prompt_for_file_name = false,
                            template = "[Image]($FILE_PATH)",
                            use_absolute_path = true,
                        },
                    },
                },
            },
        },
        config = function()
            require("codecompanion").setup({
                opts = {
                    log_level = "DEBUG",
                },
                interactions = {
                    chat = {
                        adapter = "ollama",
                        model = "qwen3-coder:30b",
                        keymaps = {
                            send = {
                                modes = {
                                    n = "<C-s>",
                                    i = "<C-s>",
                                },
                            },
                            close = {
                                modes = {
                                    n = "<C-c>",
                                    i = "<C-c>",
                                },
                            },
                        },
                    },
                    inline = {
                        keymaps = {
                            stop = {
                                modes = {
                                    n = "<C-c>",
                                    i = "<C-c>",
                                },
                            },
                        },
                    },
                    shared = {
                        keymaps = {
                            always_accept = {
                                modes = {
                                    n = "Y",
                                },
                            },
                            accept_change = {
                                modes = {
                                    n = "y",
                                },
                            },
                            reject_change = {
                                modes = {
                                    n = "n",
                                },
                            },
                            next_hunk = {
                                modes = {
                                    n = "<Tab>",
                                },
                            },
                            previous_hunk = {
                                modes = {
                                    n = "<S-Tab>",
                                },
                            },
                        },
                    },
                },
                display = {
                    action_palette = {
                        provider = "telescope",
                    },
                    chat = {
                        window = {
                            layout = "vertical",
                            position = "right",
                            width = 0.3,
                        },
                        show_header_separator = true,
                        fold_context = true,
                    },
                },
                adapters = {
                    http = {
                        ollama = function()
                            return require("codecompanion.adapters").extend("ollama", {
                                env = {
                                    url = "",
                                },
                            })
                        end,
                        openai = function()
                            return require("codecompanion.adapters").extend("openai", {
                                env = {
                                    url = "",
                                    api_key = "",
                                },
                            })
                        end,
                    },
                },
                extensions = {
                    mcphub = {
                        callback = "mcphub.extensions.codecompanion",
                        opts = {
                            make_vars = true,
                            make_slash_commands = true,
                            show_result_in_chat = true,
                        },
                    },
                },
            })
        end,
        keys = {
            { "<Leader>aa", "<CMD>CodeCompanionAction<CR>", mode = { "n" }, desc = "Open agent action" },
            { "<Leader>ac", "<CMD>CodeCompanionChat Toggle<CR>", mode = { "n" }, desc = "Toggle agent chat" },
        },
    },
}
