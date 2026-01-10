return {
  {
    "Pocco81/auto-save.nvim",
    opts = {
      enabled = true, -- Auto-save beim Start aktivieren
      execution_message = {
        message = function() return ("AutoSave: gespeichert um " .. vim.fn.strftime("%H:%M:%S")) end,
        dim = 0.18, -- Nachricht etwas dezenter anzeigen
        cleaning_interval = 1250, -- Nachricht nach 1,2s wieder löschen
      },
      trigger_events = { "InsertLeave", "TextChanged" }, -- Speichern beim Verlassen des Insert-Mode oder bei Textänderung
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        -- Nicht speichern in speziellen Fenstern (wie Dashboard oder Neo-tree)
        if utils.not_in(fn.getbufvar(buf, "&filetype"), { "neo-tree", "dashboard", "TelescopePrompt" }) then
          return true
        end
        return false
      end,
      write_all_buffers = false, -- Nur die aktuelle Datei speichern
      debounce_delay = 1000, -- 1 Sekunde warten, nachdem du aufgehört hast zu tippen
    },
  },
}