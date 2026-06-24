return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- Lädt, sobald eine Datei geöffnet wird
    opts = {
      -- Standardmäßig werden Sitzungen in ~/.local/state/nvim/sessions/ gespeichert
    },
    config = function(_, opts)
      require("persistence").setup(opts)

      -- KEYMAPS
      -- 1. Die Sitzung für das aktuelle Verzeichnis wiederherstellen
      vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, 
        { desc = "Sitzung wiederherstellen" })

      -- 2. Die absolut letzte Sitzung wiederherstellen (egal welches Projekt)
      vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, 
        { desc = "Letzte Sitzung wiederherstellen" })

      -- 3. Sitzung NICHT speichern beim Beenden
      vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, 
        { desc = "Sitzung nicht speichern" })
    end
  }
}