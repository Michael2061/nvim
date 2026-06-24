-- =============================================================================
-- NEOVIM HAUPTKONFIGURATION (init.lua)
-- =============================================================================

vim.g.lspconfig_suppress_deprecation_warning = true

-- 2. GRUNDKONFIGURATION LADEN
require("config.options")
require("config.keymaps")

-- 3. LAZY.NVIM PLUGIN-MANAGER SETUP
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
	local comment = "# "
	if vim.tbl_contains({ "lua", "cpp", "c", "go", "rust", "zig", "nim", "sql" }, ft) then
		comment = "-- "
	elseif vim.tbl_contains({ "javascript", "typescript", "jsx", "tsx", "java", "kotlin", "dart", "php", "css" }, ft) then
		comment = "// "
	elseif ft == "html" then
		comment = "<!-- "
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
		"   NEOVIM CHEATSHEET ",
		"═══════════════════════════",
		"",
		" 📁 DATEIEN & BUFFER",
		" ----------------------------",
		" <leader> ff     - Dateien suchen",
		" <leader> fg     - Text suchen (Grep)",
		" <leader> fb     - Geöffnete Buffer",
		" <leader> e      - Datei-Explorer",
		" <leader> w      - Speichern",
		" <leader> q      - Beenden",
		" <leader> bd     - Buffer schließen",
		" <Tab> / S-Tab   - Buffer wechseln",
		"",
		" 🔧 GIT",
		" ----------------------------",
		" <leader> gg     - LazyGit",
		" <leader> gd     - Git Diff",
		" ]c / [c         - Nächste/vorherige Änderung",
		" <leader> hp     - Änderung ansehen",
		" <leader> hb     - Git Blame",
		" <leader> hr     - Änderung rückgängig",
		"",
		" 🛠 EDITOR",
		" ----------------------------",
		" <leader> cf     - Manuell formatieren",
		" <leader> uf     - Auto-Format umschalten",
		" <leader> a      - AutoSave umschalten",
		" <leader> ca     - Code Action",
		" <leader> tt     - Fehler anzeigen",
		" <leader> sk     - Tastatur-Anzeige",
		"",
		" 📝 NOTIZEN & TODO",
		" ----------------------------",
		" :Notes           - Notiz-Block",
		" <leader> .      - Notizzettel",
		" <leader> st     - TODOs durchsuchen",
		" <leader> lt     - Lokale TODOs",
		" <leader> nn     - Daily Note",
		" <leader> ns     - Notizen suchen",
		" :MakeNotes      - README Vorlage",
		"",
		" 🐛 DEBUG",
		" ----------------------------",
		" <leader> db     - Breakpoint",
		" <leader> dc     - Start/Weiter",
		" <leader> di     - Step Into",
		" <leader> do     - Step Over",
		" <F5>            - Continue",
		"",
		" 🔍 NAVIGATION",
		" ----------------------------",
		" gd              - Gehe zu Definition",
		" gr              - Referenzen",
		" K               - Hover Info",
		" <leader> rn     - Umbenennen",
		" <leader> uu     - Undo History",
		" <leader> qs     - Sitzung laden",
		"",
		" [ Drücke :q zum Schließen ]",
	}

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = 52,
		height = 40,
		col = (vim.o.columns - 52) / 2,
		row = (vim.o.lines - 40) / 2,
		style = "minimal",
		border = "rounded",
	})
end, {})

-- Cheatsheet automatisch anzeigen, wenn nvim ohne Datei gestartet wird
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		if vim.fn.argc() == 0 then
			vim.defer_fn(function()
				vim.cmd("Cheatsheet")
			end, 300)
		end
	end,
})

-- =============================================================================
-- ZUSÄTZLICHE TASTENKÜRZEL
-- =============================================================================

vim.keymap.set("n", "<F1>", "<cmd>Cheatsheet<cr>", { desc = "Hilfe Cheatsheet" })
