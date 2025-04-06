return {
    "echasnovski/mini.move",
    version = false,
    event = "VeryLazy",
    config = function()
        require("mini.move").setup {
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                left = "<S-h>",
                right = "<S-l>",
                down = "<S-j>",
                up = "<S-k>",
            },

            -- Options which control moving behavior
            options = {
                -- Automatically reindent selection during linewise vertical move
                reindent_linewise = true,
            },
        }
    end,
}
