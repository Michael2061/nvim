-- =============================================================================
-- NEOVIM HAUPTKONFIGURATION (init.lua)
-- =============================================================================

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = '/usr/bin/python3'

-- 1. LSP & WARNUNGEN DEAKTIVIEREN
-- Deaktiviert die lspconfig-Warnung für Neovim 0.11+
vim.g.lspconfig_suppress_deprecation_warning = true

-- Falls Plugins die globale Variable ignorieren, Meldungen hart ausschalten:
local silent_notify = function(msg, level, opts)
	if msg:find("require('lspconfig')") or msg:find("deprecated") then
		return
	end
	return vim.health.report_info and vim.health.report_info(msg) or print(msg)
end
vim.notify = silent_notify

-- 2. GRUNDKONFIGURATION LADEN
require("config.options")
require("config.keymaps")

-- 3. LAZY.NVIM PLUGIN-MANAGER SETUP
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugins laden (Ordner lua/plugins wird automatisch gescannt)
require("lazy").setup("plugins", {
	checker = {
		enabled = true,   -- Aktiviert die automatische Prüfung auf Updates
		notify = true,    -- Zeigt eine Benachrichtigung beim Start, wenn Updates da sind
		frequency = 3600, -- Prüft einmal pro Stunde (in Sekunden)
	},
	ui = {
		border = "rounded", -- Optional: macht das Lazy-Fenster schöner (passend zu deinem Cheatsheet)
	},
})
-- =============================================================================
-- EIGENE BEFEHLE (USER COMMANDS)
-- =============================================================================

-- BEFEHL 1: :Notes
-- Fügt einen schicken Notizblock oben in die aktuelle Datei ein
vim.api.nvim_create_user_command("Notes", function()
	local ft = vim.bo.filetype
	local comment = "# " -- Standard für Python, Shell, Config
	if ft == "lua" or ft == "cpp" then
		comment = "-- "
	elseif ft == "javascript" or ft == "typescript" then
		comment = "// "
	end

	local lines = {
		comment .. "------------------------------------------------------------------------------",
		comment .. "📝 NOTIZEN & LOGIK:",
		comment .. "Hier beschreiben, was die Datei macht...",
		comment .. "",
		comment .. "📋 LOKALE TODO LISTE:",
		comment .. "TODO: Ersten Meilenstein planen ",
		comment .. "FIX:  Bekannte Probleme hier auflisten ",
		comment .. "------------------------------------------------------------------------------",
	}
	-- Zeilen am Anfang des Buffers einfügen
	vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end, {})

-- BEFEHL 2: :MakeNotes
-- Erstellt eine schnelle README-Vorlage für das Projekt
vim.api.nvim_create_user_command("MakeNotes", function()
	local lines = {
		"# 🚀 Projekt Notizen: " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
		"",
		"> [!NOTE]",
		"Letztes Update: " .. os.date("%d.%m.%Y"),
		"",
		"## 🛠 Wichtige Befehle",
		"- [ ] TODO: Dokumentiere die ersten Schritte ",
		"",
		"## 📝 Notizen",
		"- ",
	}
	vim.api.nvim_put(lines, "l", true, true)
end, {})

-- BEFEHL 3: :Cheatsheet
-- Öffnet ein schwebendes Fenster mit deinen wichtigsten Kürzeln
vim.api.nvim_create_user_command("Cheatsheet", function()
	local buf = vim.api.nvim_create_buf(false, true)
	local content = {
		"   NEOVIM SETUP CHEATSHEET ",
		"======================================",
		"",
		" 📝 NOTIZEN & TODOS",
		" ------------------------------------",
		" :Notes          - Notiz-Block einfügen",
		" <leader> .      - Projekt Notizzettel",
		" <leader> S      - Alle Zettel suchen",
		" <leader> st     - Alle Projekt-TODOs",
		" <leader> lt     - Lokale TODO Liste",
		"",
		" 🛠 TOOLS & NAVIGATION",
		" ------------------------------------",
		" <leader> gg     - LazyGit öffnen",
		" <leader> nh     - Benachrichtigungen",
		" <leader> bd     - Buffer schließen",
		" :MakeNotes      - README Vorlage",
		"",
		" [ Drücke :q zum Schließen ]",
	}

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = 50,
		height = 22,
		col = (vim.o.columns - 50) / 2,
		row = (vim.o.lines - 22) / 2,
		style = "minimal",
		border = "rounded",
	})
end, {})

-- =============================================================================
-- ZUSÄTZLICHE TASTENKÜRZEL
-- =============================================================================

-- Schnellzugriff auf das Cheatsheet mit der F1-Taste
vim.keymap.set("n", "<F1>", "<cmd>Cheatsheet<cr>", { desc = "Hilfe Cheatsheet" })

-- Schnellzugriff auf TODOs (Telescope)
vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Suche alle TODOs" })
