-- Leader-Taste auf Leertaste setzen
vim.g.mapleader = " "

-- Fenster-Navigation (Alt + h/j/k/l)
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-l>', '<C-w>l')

-- Schnelles Speichern und Beenden
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')

-- Buffer-Navigation (Tabs)
vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { silent = true })
vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { silent = true })
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { silent = true })
vim.keymap.set('n', '<A-S-h>', ':BufferLineMovePrev<CR>', { silent = true })
vim.keymap.set('n', '<A-S-l>', ':BufferLineMoveNext<CR>', { silent = true })
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })

-- Formatieren mit Leertaste + f
vim.keymap.set("n", "<leader>f", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end, { desc = "Format file" })

-----------------------------------------------------------
-- LERN-MODUS: PFEILTASTEN-STEUERUNG
-----------------------------------------------------------

-- 1. Im Normal Mode DEAKTIVIEREN (Zwingt dich zu h,j,k,l)
vim.keymap.set("n", "<up>", '<cmd>echo "Nutze k!"<cr>')
vim.keymap.set("n", "<down>", '<cmd>echo "Nutze j!"<cr>')
vim.keymap.set("n", "<left>", '<cmd>echo "Nutze h!"<cr>')
vim.keymap.set("n", "<right>", '<cmd>echo "Nutze l!"<cr>')

-- 2. Im Insert Mode ERLAUBEN (Für Schreibkomfort)
vim.keymap.set("i", "<up>", "<C-o>gk", { noremap = true, silent = true })
vim.keymap.set("i", "<down>", "<C-o>gj", { noremap = true, silent = true })
vim.keymap.set("i", "<left>", "<left>", { noremap = true, silent = true })
vim.keymap.set("i", "<right>", "<right>", { noremap = true, silent = true })

-- Bonus: Schneller aus dem Insert Mode raus
vim.keymap.set("i", "jk", "<Esc>", { desc = "Zurück zum Normal Mode" })

vim.keymap.set("n", "<leader>a", ":ASToggle<CR>", { desc = "AutoSave Umschalten" })