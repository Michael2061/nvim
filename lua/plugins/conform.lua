return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                -- Ruff übernimmt jetzt das Sortieren der Imports UND das Formatieren
                python = { "ruff_organize_imports", "ruff_format" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                json = { "prettier" },
                bash = { "shfmt" },
                ["_"] = { "trim_whitespace" },
            },
        },
    },
}
