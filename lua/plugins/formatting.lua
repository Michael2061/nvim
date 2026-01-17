return {
  {
    "stevearc/conform.nvim",
    dependencies = {
      "zapling/mason-conform.nvim",
    },
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
    local conform = require("conform")

    -- 1. Zuerst Mason-Conform einrichten
    require("mason-conform").setup({
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
        "php-cs-fixer", -- Da du PHP installiert hast, ist das nützlich!
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
        markdown = { "prettierd" }, -- Auch Markdown automatisch hübsch machen!
        go = { "gofmt", "goimports" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        sql = { "sql_formatter" },
        php = { "php-cs-fixer" },
      },

      -- Verbessertes Format on Save mit Toggle-Support
      format_on_save = function(bufnr)
        -- Falls du vim.g.disable_autoformat in den Keymaps setzt:
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
          end
          return {
            timeout_ms = 500,
            lsp_format = "fallback",
          }
          end,

          -- Optionale Benachrichtigung bei Fehlern
          notify_on_error = true,
    })
    end,
  },
}
