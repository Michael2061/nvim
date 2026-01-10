return {
  {
    'saghen/blink.cmp',
    version = '*', -- Nutzt die stabilste Version für 0.11
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  }
}
