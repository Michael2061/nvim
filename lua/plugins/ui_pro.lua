return {
  {
    "echasnovski/mini.animate",
    version = false,
    opts = {}, -- Die Standard-Einstellungen sind bereits sehr gut
  },

  -- 2. Noice.nvim (Die Benutzeroberfläche revolutionieren)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify", -- Sorgt für schicke Pop-up Meldungen
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,    -- Suchzeile unten wie früher, aber schöner
        command_palette = true,  -- Befehle (:) erscheinen in der Mitte
        long_message_to_split = true,
      },
    },
  },

  -- 3. Trouble.nvim (Fehler-Zentrale)
  {
    "folke/trouble.nvim",
    opts = {}, -- Standard-Setup
    cmd = "Trouble",
    keys = {
      {
        "<leader>tt",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Projekt-Fehler anzeigen (Trouble)",
      },
    },
  },
}