-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

    -- == Examples of Adding Plugins ==

    "andweeb/presence.nvim",
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require("lsp_signature").setup() end,
    },

    -- == Examples of Overriding Plugins ==

    -- customize dashboard options
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = {
                preset = {
                    header = table.concat({
                        "███████╗ ██████╗  █████╗ ███╗   ███╗██╗   ██╗",
                        "██╔════╝██╔═══██╗██╔══██╗████╗ ████║╚██╗ ██╔╝",
                        "█████╗  ██║   ██║███████║██╔████╔██║ ╚████╔╝ ",
                        "██╔══╝  ██║   ██║██╔══██║██║╚██╔╝██║  ╚██╔╝  ",
                        "██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║   ██║   ",
                        "╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝   ╚═╝   ",
                        " ",
                        "     ███╗   ██╗██╗   ██╗██╗███╗   ███╗       ",
                        "     ████╗  ██║██║   ██║██║████╗ ████║       ",
                        "     ██╔██╗ ██║██║   ██║██║██╔████╔██║       ",
                        "     ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║       ",
                        "     ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║       ",
                        "     ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝       ",
                    }, "\n"),
                },
            },
        },
    },

    -- Customize todo comments
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            keywords = {
                TEMP = {
                    icon = " ",
                    color = "info",
                },
            },
        },
    },

    -- You can disable default plugins as follows:
    { "max397574/better-escape.nvim", enabled = false },

    -- Add themes
    { "projekt0n/github-nvim-theme", name = "github-theme" },

    -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
    {
        "L3MON4D3/LuaSnip",
        config = function(plugin, opts)
            require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
            -- add more custom luasnip configuration such as filetype extend or custom snippets
            local luasnip = require "luasnip"
            luasnip.filetype_extend("javascript", { "javascriptreact" })
        end,
    },

    {
        "windwp/nvim-autopairs",
        config = function(plugin, opts)
            require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
            -- add more custom autopairs configuration such as custom rules
            local npairs = require "nvim-autopairs"
            local Rule = require "nvim-autopairs.rule"
            local cond = require "nvim-autopairs.conds"
            npairs.add_rules(
                {
                    Rule("$", "$", { "tex", "latex" })
                        -- don't add a pair if the next character is %
                        :with_pair(
                            cond.not_after_regex "%%"
                        )
                        -- don't add a pair if  the previous character is xxx
                        :with_pair(
                            cond.not_before_regex("xxx", 3)
                        )
                        -- don't move right when repeat character
                        :with_move(cond.none())
                        -- don't delete if the next character is xx
                        :with_del(
                            cond.not_after_regex "xx"
                        )
                        -- disable adding a newline when you press <cr>
                        :with_cr(cond.none()),
                },
                -- disable for .vim files, but it work for another filetypes
                Rule("a", "a", "-vim")
            )
        end,
    },
    {
        "chrisbra/matchit",
    },
    {
        "olrtg/nvim-emmet",
        config = function() vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation) end,
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },
    {
        "braxtons12/blame_line.nvim",
        config = function()
            require("blame_line").setup {
                show_in_insert = false,
                prefix = "     ",
            }
        end,
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_show_help = 0
            -- vim.g.db_ui_use_nvim_notify = 1
            vim.g.db_ui_win_position = "right"
            -- vim.g.db_ui_disable_mappings_dbui = 1
            -- vim.g.db_ui_disable_mappings_dbout = 1
            -- vim.g.db_ui_disable_mappings_sql = 1
            -- vim.g.db_ui_use_postgres_views = 0
        end,
        keys = {
            { "<leader>Dt", "<cmd>DBUIToggle<cr>", desc = "Toggle UI" },
            { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find Buffer" },
            { "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename Buffer" },
            { "<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },
        },
    },
    {
        "folke/trouble.nvim",
        optional = true,
        specs = {
            "folke/snacks.nvim",
            opts = function(_, opts)
                return vim.tbl_deep_extend("force", opts or {}, {
                    picker = {
                        actions = require("trouble.sources.snacks").actions,
                        win = {
                            input = {
                                keys = {
                                    ["<c-t>"] = {
                                        "trouble_open",
                                        mode = { "n", "i" },
                                    },
                                },
                            },
                        },
                    },
                })
            end,
        },
    },
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        keys = {
            { "<leader>U", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
        },
        init = function()
            vim.g.undotree_WindowLayout = 2 -- Undotree on left, diff below
            vim.g.undotree_ShortIndicators = 0 -- Use shorter timestamps
            vim.g.undotree_SetFocusWhenToggle = 1 -- Focus on undotree when toggled
            vim.g.undotree_DiffAutoOpen = 0 -- Auto open diff window
            vim.g.undotree_SplitWidth = 36 -- Set undotree window width
            vim.g.undotree_DiffpanelHeight = 30 -- Set diff panel height
        end,
    },
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>am", "<cmd>MCPHub<cr>", desc = "mcphub: open" },
        },
        -- build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
        config = function()
            require("mcphub").setup {
                port = 37373,
                config = vim.fn.expand "~/.config/mcphub/servers.json",
                native_servers = {},

                mcp_request_timeout = 10000, -- 10 seconds
                builtin_tools = {},

                auto_approve = false,
                auto_toggle_mcp_servers = true,
                extensions = {
                    avante = {
                        make_slash_commands = true,
                    },
                },

                ui = {
                    window = {
                        width = 0.8,
                        height = 0.8,
                        relative = "editor",
                        zindex = 50,
                        border = "rounded",
                    },
                    wo = {},
                },

                on_ready = function(hub) end,
                on_error = function(err) end,

                use_bundled_binary = false, -- Explicitly use global mcp-hub executable

                -- server_url = nil, -- defaults to `http://localhost:port`
                shutdown_delay = 600000, -- 10 minutes
                log = {
                    level = vim.log.levels.INFO,
                    to_file = true,
                    file_path = vim.fn.stdpath "state" .. "/mcphub.log",
                    prefix = "MCPHub",
                },
            }
        end,
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            provider = "copilot",
            providers = {
                copilot = {
                    model = "gpt-4.1",
                },
            },
            -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
            system_prompt = function()
                local hub = require("mcphub").get_hub_instance()
                if hub and hub.get_active_servers_prompt then return hub:get_active_servers_prompt() end
            end,
            -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
            custom_tools = function()
                return {
                    require("mcphub.extensions.avante").mcp_tool(),
                }
            end,
            auto_suggestions_provider = "copilot",
            selector = {
                provider = "snacks", -- Use Snacks.picker as the file selector
            },
            mappings = {
                --- @class AvanteConflictMappings
                suggestion = {
                    accept = "<C-l>",
                },
            },
            hints = { enabled = true },
            windows = {
                width = 40,
            },
        },
        keys = {
            { "<leader>ax", "<cmd>AvanteClear<cr>", desc = "avante: clear history" },
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick", -- for file_selector provider mini.pick
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- Make sure to set this up properly if you have lazy=true
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
}
