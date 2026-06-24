return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- Größe und Form
        size = 20,
        open_mapping = [[<A-i>]], -- Geändert auf Alt + i (angenehmer als Strg+\)
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float", -- Schwebendes Fenster
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved", -- Schicke abgerundete Ecken
          winblend = 3,
        },
      })

      -- Diese Funktion erlaubt es dir, das Terminal wie eine normale Datei zu verlassen
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        -- Mit Esc oder jk kommst du aus dem Schreibmodus des Terminals raus
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        -- Ermöglicht Fenster-Navigation direkt aus dem Terminal
        vim.keymap.set('t', '<A-h>', [[<C-\><C-n><C-w>h]], opts)
        vim.keymap.set('t', '<A-j>', [[<C-\><C-n><C-w>j]], opts)
        vim.keymap.set('t', '<A-k>', [[<C-\><C-n><C-w>k]], opts)
        vim.keymap.set('t', '<A-l>', [[<C-\><C-n><C-w>l]], opts)
      end

      -- Aktiviert die Keymaps automatisch, wenn ein Terminal geöffnet wird
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
  },
}