return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- Hier kannst du das Design anpassen
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      
      -- Wir gruppieren die Befehle, damit das Menü schön ordentlich ist
      wk.add({
        { "<leader>f", group = "Datei finden & Format" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Git Hunks (Änderungen)" },
        { "<leader>e", desc = "Datei-Explorer öffnen" },
        { "<leader>w", desc = "Datei speichern" },
        { "<leader>q", desc = "Beenden" },
      })
    end,
  },
}