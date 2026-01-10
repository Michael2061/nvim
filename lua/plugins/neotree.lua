return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Keymap zum Öffnen/Schließen mit <Leader>e (meistens Leertaste + e)
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { silent = true })
    end
  }
}