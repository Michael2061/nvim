local headers = {
  {
    "       ⚡ CachyOS Neovim ⚡       ",
    "    Ready to code some magic     ",
  },
  {
    [[   __  _                _        ]],
    [[  |  \| | ___  _____  _(_)_ __   ]],
    [[  | . ` |/ _ \/ _ \ \/ / | '_ \  ]],
    [[  |_|\__|\___/\___/\_/|_|_| |_|  ]],
  },
}

local random_header = headers[math.random(#headers)]

return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dashboard",
        callback = function()
          -- 1. FEHLER BEHEBEN: Modifiable auf true setzen
          vim.opt_local.modifiable = true 
          
          -- 2. TASTE 'i' STUMM SCHALTEN (Nur im Dashboard)
          -- Das verhindert, dass du aus Versehen im Dashboard tippst
          vim.keymap.set("n", "i", "<nop>", { buffer = true, silent = true })

          -- 3. Deine bisherigen Optik-Einstellungen
          vim.opt_local.list = false
          pcall(function() vim.cmd("IBLDisable") end)
        end,
      })

      return {
        theme = "doom",
        config = {
          header = random_header,
          disable_move = true, 
          center = {
            { action = "ene | startinsert", desc = " Neue Datei erstellen", icon = "📄 ", key = "n" },
            -- 1. Suche & Navigation
            { action = "Telescope find_files", desc = " Datei suchen      ", icon = "🔎 ", key = "f" },
            { action = "Telescope oldfiles",   desc = " Letzte Dateien    ", icon = "🕒 ", key = "r" },
            { action = "Telescope commands",   desc = " Befehle anzeigen  ", icon = "⌨️  ", key = "c" },
            
            -- 2. Tools & Debugging
            { action = "ToggleTerm",           desc = " Terminal öffnen   ", icon = "💻 ", key = "t" },
            { action = "Mason",                desc = " Sprachen/LSP Man. ", icon = "📦 ", key = "m" },
            { action = "Telescope dap list_breakpoints", desc = " Breakpoints zeigen ", icon = "🐞 ", key = "d" }, -- Hier ist er wieder!
            
            -- 3. Info & Exit
            { action = "Telescope keymaps",    desc = " Keymap Cheat      ", icon = "📜 ", key = "k" },
            { action = "qa",                   desc = " Beenden           ", icon = "🚪 ", key = "q" },
          },
          footer = {
            "",
            "⌨️  Quick Cheat Sheet (Updated):",
            "  SPC w   -> Speichern        |  SPC q   -> Schließen",
            "  SPC c f -> Formatieren      |  jk      -> Exit Insert",
            "  S-l/h   -> Tabs wechseln    |  SPC b x -> Buffer schließen",
            "  F5      -> Start/Weiter     |  F10     -> Step Over (Überspringen)",
            "  F11     -> Step Into        |  SPC b   -> Breakpoint setzen",
            "  Alt + i -> Terminal (An/Aus)|  SPC m   -> Mason Menü",
            "  SPC a   -> AutoSave (An/Aus)|  SPC u f -> Auto-Format Toggle",
            "",
            " Viel Spaß beim Programmieren mit CachyOS!",
          },
        },
      }
    end,
  }
}
