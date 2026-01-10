return {
  {
    "stevearc/conform.nvim",
    dependencies = {
      -- Dieses Plugin sorgt für die automatische Installation via Mason
      "zapling/mason-conform.nvim",
    },
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      local conform = require("conform")

      -- 1. Zuerst Mason-Conform einrichten
      require("mason-conform").setup({
        -- Hier sagst du Mason, welche Formatter immer da sein sollen
        ensure_installed = {
          "stylua",
          "black",
          "isort",
          "prettierd",
          "shfmt",
          "clang-format",
          "sql-formatter",
          "goimports",
          "rustfmt",
        },
      })

      -- 2. Dann Conform selbst konfigurieren
      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          html = { "prettierd", "prettier", stop_after_first = true },
          css = { "prettierd", "prettier", stop_after_first = true },
          json = { "prettierd", "prettier", stop_after_first = true },
          go = { "gofmt", "goimports" },
          rust = { "rustfmt" },
          sh = { "shfmt" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          sql = { "sql_formatter" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end,
  },
}