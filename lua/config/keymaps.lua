-- Leader-Taste auf Leertaste setzen
vim.g.mapleader = " "

-----------------------------------------------------------
-- PROVIDER & FIXES
-----------------------------------------------------------
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_mercurial = 0
vim.g.python3_host_prog = '/usr/bin/python3'

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
		vim.cmd("noh")
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

-- Buffer-Navigation
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<leader>bx", ":bdelete<CR>", { silent = true, desc = "Buffer schließen" })
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })

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

-- NEU: Auto-Format Toggle (Umschalten des Speichern-Formats)
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

-- Telescope Suche (Häufige Befehle ohne Overlap)
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
