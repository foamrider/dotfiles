-- Customize Mason

---@type LazySpec
return {
    -- use mason-tool-installer for automatically installing Mason packages
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- overrides `require("mason-tool-installer").setup(...)`
        opts = {
            -- Make sure to use the names found in `:Mason`
            ensure_installed = {
                -- install language servers
                "lua-language-server",
                "typescript-language-server",
                "emmet-language-server",
                "deno",
                "eslint-lsp",
                "svelte-language-server",
                "vue-language-server",
                "json-lsp",
                "html-lsp",
                "css-lsp",
                "powershell-editor-services",

                -- install formatters
                "stylua",
                "prettierd",

                -- install debuggers
                "debugpy",

                -- install any other package
                "tree-sitter-cli",
            },
        },
    },
    {
        "jay-babu/mason-null-ls.nvim",
        opts = {
            handlers = {
                -- for prettier
                prettier = function()
                    require("null-ls").register(require("null-ls").builtins.formatting.prettier.with {
                        condition = function(utils)
                            return utils.root_has_file ".prettierrc"
                                or utils.root_has_file ".prettierrc.json"
                                or utils.root_has_file ".prettierrc.js"
                        end,
                    })
                end,
                -- for prettierd
                prettierd = function()
                    require("null-ls").register(require("null-ls").builtins.formatting.prettierd.with {
                        condition = function(utils)
                            return utils.root_has_file ".prettierrc"
                                or utils.root_has_file ".prettierrc.json"
                                or utils.root_has_file ".prettierrc.js"
                        end,
                    })
                end,
            },
        },
    },
}
