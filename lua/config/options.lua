vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.conceallevel = 2 -- Erlaubt Neovim, Symbole durch Icons zu ersetzen
vim.opt.cpoptions:append("I")
vim.opt.backspace = "indent,eol,start"
vim.opt.cursorline = true -- Markiert die aktuelle Zeile (hilft bei der Orientierung)
vim.opt.scrolloff = 8 -- Lässt immer 8 Zeilen Platz beim Scrollen nach unten/oben
vim.opt.sidescrolloff = 8 -- Gleiches für horizontales Scrollen

local opt = vim.opt

opt.number = true -- Zeilennummern anzeigen
opt.relativenumber = true -- Relative Zeilennummern (super für Sprünge)
opt.shiftwidth = 4 -- Einrückung
opt.tabstop = 4
opt.expandtab = true -- Leerzeichen statt Tabs (außer in Go, das regelt später der LSP)
-- opt.smartindent = true
opt.termguicolors = true -- Volle Farben im Terminal
opt.ignorecase = true -- Suche ignoriert Groß/Kleinschreibung...
opt.smartcase = true -- ...außer man schreibt groß.

vim.opt.guicursor = "n-v-c-i:block" -- Macht den Cursor immer zu einem Block
