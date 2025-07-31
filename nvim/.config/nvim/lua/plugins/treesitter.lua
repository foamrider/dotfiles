-- Customize Treesitter

---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {
            "lua",
            "vim",
            "svelte",
            "javascript",
            "powershell",
            "bash",
            "html",
            "css",
            "scss",
            "typescript",
            "hurl",
            -- add more arguments for adding more treesitter parsers
        },
    },
}
