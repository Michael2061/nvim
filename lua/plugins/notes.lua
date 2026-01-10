return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    -- Das Plugin lädt, sobald du eine Markdown Datei öffnest ODER den Befehl nutzt
    cmd = { "ObsidianToday", "ObsidianSearch", "ObsidianQuickSwitch" },
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- Wir definieren die Tasten HIER, damit E35 nicht mehr auftritt
    init = function()
      vim.keymap.set("n", "<leader>nn", "<cmd>ObsidianToday<cr>", { desc = "Daily Note öffnen" })
      vim.keymap.set("n", "<leader>ns", "<cmd>ObsidianSearch<cr>", { desc = "Notizen suchen" })
      -- Setzt das Level automatisch, wenn du Notizen nutzt:
      vim.opt.conceallevel = 2
    end,
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/notes",
        },
      },
      daily_notes = {
        folder = "dailies",
        date_format = "%Y-%m-%d",
        template = "daily_template.md",
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
      },
      ui = { enable = true },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  }
}