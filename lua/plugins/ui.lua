return {
  -- 1. TOKYO NIGHT THEME
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
    require("tokyonight").setup(opts)

    -- Funktion, die den Hintergrund auf "NONE" setzt
    local function apply_transparency()
    local groups = {
      "Normal", "NormalFloat", "NormalNC", "NvimTreeNormal",
      "NeoTreeNormal", "NeoTreeNormalNC", "StatusLine",
      "SignColumn", "Folded", "EndOfBuffer", "MsgArea",
      "WhichKey", "WhichKeyFloat", "WinBar", "WinBarNC"
    }
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
      end
      end

      -- Farbschema aktivieren
      vim.cmd.colorscheme("tokyonight-night")

      -- Transparenz sofort anwenden
      apply_transparency()

      -- Sicherstellen, dass es bei jedem Schema-Wechsel aktiv bleibt
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = apply_transparency,
      })
      end,
  },

  -- 2. TREESITTER
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = "all",
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
  },

  -- 3. NEO-TREE
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      default_component_configs = {
        icon = {
          folder_closed = "▶",
          folder_open = "▼",
          folder_empty = "○",
          default = "•",
        },
      },
    },
  },

  -- 4. LUALINE
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_x = {
          {
            function()
            local msg = 'No LSP'
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if next(clients) == nil then return msg end
              local client_names = {}
              for _, client in ipairs(clients) do
                table.insert(client_names, client.name)
                end
                return 'LSP: ' .. table.concat(client_names, ', ')
                end,
                icon = '🚀 ',
                color = { fg = '#7aa2f7', gui = 'bold' },
          },
          'encoding',
          'fileformat',
          'filetype',
        },
      },
    },
  },
}
