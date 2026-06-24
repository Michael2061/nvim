return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers", -- zeigt geöffnete Dateien an
          separator_style = "thin", -- eleganter Look
          always_show_bufferline = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          -- Sorgt dafür, dass die Tabs Platz machen, wenn Neo-tree offen ist
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            }
          },
        }
      })
    end,
  }
}