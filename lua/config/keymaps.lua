-- Leader-Taste auf Leertaste setzen
vim.g.mapleader = " "

-----------------------------------------------------------
-- PROVIDER & FIXES
-----------------------------------------------------------
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_mercurial = 0
vim.g.python3_host_prog = "/usr/bin/python3"

-----------------------------------------------------------
-- GLOBALE STEUERUNG (ESC & POPUPS)
-----------------------------------------------------------
vim.keymap.set("n", "<Esc>", function()
	local wins = vim.api.nvim_list_wins()
	for _, win in ipairs(wins) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_win_close(win, false)
		end
	end
	-- Versteckt Such-Hervorhebungen
	vim.cmd("noh")
	-- Schickt echtes Esc, um z.B. Insert-Mode zu beenden
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end, { silent = true, desc = "Schließe alle Popups und lösche Suche" })

-----------------------------------------------------------
-- NAVIGATION & FENSTER
-----------------------------------------------------------
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")

vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- Buffer-Navigation (KONFLIKT GELÖST)
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })

-- Alle Buffer-Befehle starten jetzt mit <leader>b...
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { silent = true, desc = "Buffer schließen" })
vim.keymap.set("n", "<leader>bx", ":bdelete!<CR>", { silent = true, desc = "Buffer erzwingen schließen" })
vim.keymap.set("n", "<leader>ba", ":bufdo bd<CR>", { silent = true, desc = "Alle Buffer schließen" })

-----------------------------------------------------------
-- DEBUGGING (DAP) (Starten alle mit <leader>d)
-----------------------------------------------------------
-- Den Breakpoint verschieben wir von <leader>b auf <leader>db
vim.keymap.set("n", "<leader>db", function()
	local ok, dap = pcall(require, "dap")
	if ok then
		dap.toggle_breakpoint()
	else
		print("DAP nicht gefunden")
	end
end, { desc = "Debug: Breakpoint setzen" })

-- Weitere nützliche Debug-Keys (optional, aber empfohlen für Ordnung)
vim.keymap.set("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "Debug: Start/Weiter" })
vim.keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<leader>do", function()
	require("dap").step_over()
end, { desc = "Debug: Step Over" })
-----------------------------------------------------------
-- LSP & CODE ACTIONS
-----------------------------------------------------------
-- Code Actions mit Vorschau (hier war ein Fehler im alten Script)
vim.keymap.set({ "v", "n" }, "<leader>ca", function()
	require("actions-preview").code_actions()
end, { desc = "Code Action Vorschau" })

-----------------------------------------------------------
-- TOOLS (FORMAT, TODO, AUTOSAVE)
-----------------------------------------------------------

-- Manuelles Formatieren
vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Code Format" })

-- Auto-Format Toggle (FIXED: Die falsche Funktion entfernt)
vim.keymap.set("n", "<leader>uf", function()
	if vim.g.disable_autoformat then
		vim.g.disable_autoformat = false
		vim.notify("Auto-Format AKTIVIERT", vim.log.levels.INFO, { title = "Conform" })
	else
		vim.g.disable_autoformat = true
		vim.notify("Auto-Format DEAKTIVIERT", vim.log.levels.WARN, { title = "Conform" })
	end
end, { desc = "Toggle Auto-Format on Save" })

vim.keymap.set("n", "<leader>a", ":ASToggle<CR>", { desc = "AutoSave Umschalten" })

-- Telescope Suche
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Dateien finden" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Text suchen (Grep)" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Offene Buffer finden" })

-- Telescope TODO Suche
vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Suche alle TODOs" })
vim.keymap.set("n", "<leader>lt", "<cmd>TodoLocList<cr>", { desc = "Lokale TODO Liste" })

-----------------------------------------------------------
-- LERN-MODUS: PFEILTASTEN-STEUERUNG
-----------------------------------------------------------
vim.keymap.set("n", "<up>", '<cmd>echo "Nutze k!"<cr>')
vim.keymap.set("n", "<down>", '<cmd>echo "Nutze j!"<cr>')
vim.keymap.set("n", "<left>", '<cmd>echo "Nutze h!"<cr>')
vim.keymap.set("n", "<right>", '<cmd>echo "Nutze l!"<cr>')

vim.keymap.set("i", "<up>", "<C-o>gk", { noremap = true, silent = true })
vim.keymap.set("i", "<down>", "<C-o>gj", { noremap = true, silent = true })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Zurück zum Normal Mode" })
