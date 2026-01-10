-- Deaktiviert die lspconfig-Warnung für Neovim 0.11+
vim.g.lspconfig_suppress_deprecation_warning = true

-- Falls das Plugin die globale Variable ignoriert, schalten wir die Meldung hart aus:
local silent_notify = function(msg, level, opts)
  if msg:find("require('lspconfig')") or msg:find("deprecated") then
    return
  end
  return vim.health.report_info and vim.health.report_info(msg) or print(msg)
end
vim.notify = silent_notify

require("config.options")
require("config.keymaps")


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Plugins laden (Ordner lua/plugins wird automatisch gescannt)
require("lazy").setup("plugins")
