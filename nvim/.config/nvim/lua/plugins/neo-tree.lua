--- @type LazySpec
return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
        enable_diagnostics = true,
        window = {
            position = "float",
        },
        popup_border_style = "rounded",
        default_component_configs = {
            last_modified = {
                format = "relative",
            },
            git_status = {
                symbols = {
                    added = "󰬈",
                    modified = "󰬔",
                    deleted = "󰬋",
                    renamed = "󰬙",
                    untracked = "󰬛",
                    ignored = "󰬐",
                    unstaged = "󰬜",
                    staged = "󰬚",
                    conflict = "󰬊",
                },
            },
        },
    },
}
