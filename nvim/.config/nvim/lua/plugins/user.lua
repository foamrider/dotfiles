-- You can also add or configure plugins by creating files in this `plugins/` folder
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

    -- customize alpha options
    {
        "goolord/alpha-nvim",
        opts = function(_, opts)
            -- customize the dashboard header
            opts.section.header.val = {

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
            }
            return opts
        end,
    },

    -- You can disable default plugins as follows:
    { "max397574/better-escape.nvim", enabled = false },

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
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "kristijanhusak/vim-dadbod-completion",
            },
            -- override the options table that is used in the `require("cmp").setup()` call
            opts = function(_, opts)
                -- opts parameter is the default options table
                -- the function is lazy loaded so cmp is able to be required
                local cmp = require "cmp"
                -- modify the sources part of the options table
                opts.sources = cmp.config.sources {
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip", priority = 750 },
                    { name = "buffer", priority = 500 },
                    { name = "path", priority = 250 },
                    { name = "vim-dadbod-completion", priority = 700 }, -- add new source
                }
                -- return the new table to be used
                return opts
            end,
        },
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "stevearc/conform.nvim",
        enabled = false,
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        -- This will provide type hinting with LuaLS
        ---@module "conform"
        ---@type conform.setupOpts
        opts = {
            formatters_by_ft = {
                vue = { "eslint_d", "prettierd", lsp_format = "fallback", stop_after_first = true },
            },
        },
    },
}
