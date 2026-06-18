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
                    default = "<C-a>",
                },
                submit = {
                    normal = "<C-s>",
                    insert = "<C-s>",
                },
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
            }

            mappings = vim.tbl_filter(function(m)
                return m[1] and #m[1] > 0
            end, mappings)

            return vim.list_extend(mappings, keys)
        end,
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
                            change_adapter = {
                                modes = {
                                    n = "<Leader>am",
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
                        fold_context = true,
                    },
                },
                adapters = {
                    http = {
                        ollama = function()
                            return require("codecompanion.adapters").extend("ollama", {
                                env = {
                                    url = function()
                                        return os.getenv("OLLAMA_HOST")
                                    end,
                                },
                            })
                        end,
                        openai_compatible = function()
                            return require("codecompanion.adapters").extend("openai_compatible", {
                                env = {
                                    url = function()
                                        return os.getenv("OPENAI_HOST")
                                    end,
                                    api_key = function()
                                        return os.getenv("OPENAI_API_KEY")
                                    end,
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
            { "<Leader>at", "<CMD>CodeCompanionChat Toggle<CR>", mode = { "n" }, desc = "Toggle agent chat" },
        },
    },
}
