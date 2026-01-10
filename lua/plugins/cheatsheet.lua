return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300 -- Menü erscheint nach 300ms
    end,
    opts = {
      -- Hier kannst du das Design anpassen
      preset = "modern",
    },
  },
}