return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      -- Dateisuche mit Leertaste + ff
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      -- Textsuche in allen Dateien mit Leertaste + fg
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      -- Suche in offenen Tabs mit Leertaste + fb
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    end
  }
}