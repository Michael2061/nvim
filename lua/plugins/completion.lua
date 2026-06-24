return {
  {
    'saghen/blink.cmp',
    -- HIER HINZUGEFÜGT: Lädt die Snippet-Sammlung (friendly-snippets)
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '*',
    opts = {
      keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Esc>'] = { 'hide', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      completion = {
        menu = { border = 'rounded' },
        documentation = { window = { border = 'rounded' } },
      },

      -- Blink hat ein eingebautes Snippet-System,
      -- das friendly-snippets automatisch erkennt.
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  }
}
