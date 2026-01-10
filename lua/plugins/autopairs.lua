return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- Lädt erst, wenn du anfängst zu tippen (spart Zeit beim Start)
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- Nutzt Treesitter, um noch intelligenter zu sein
        disable_filetype = { "TelescopePrompt" }, -- Nicht in der Suche stören
      })
    end,
  },
}