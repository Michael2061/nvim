return {
  -- 1. TOKYO NIGHT THEME
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true, -- Das aktiviert die Basis-Transparenz sauber
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      -- Wir nutzen den eingebauten on_highlights Hook von Tokyonight
      on_highlights = function(hl, c)
      -- Hier kannst du spezifische Gruppen überschreiben, falls nötig
      -- Das ist stabiler als eine separate Funktion
      hl.NormalFloat = { bg = "none" }
      hl.FloatBorder = { bg = "none" }
      end,
    },
    config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- 2. TREESITTER
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- 'lazy = false' und 'priority' sind hier gut, um es früh zu laden
    lazy = false,
    priority = 1000,
    config = function()
    -- Wir laden das Modul ERST HIER drinnen
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
      end

      configs.setup({
        ensure_installed = {
          "python", "lua", "vim", "vimdoc", "query", "bash",
          "markdown", "markdown_inline", "regex",
          "css", "html", "javascript", "latex", "scss", "sql"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
      end,
  },

  -- 3. NEO-TREE
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
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
        theme = "tokyonight", -- Explizit auf tokyonight setzen statt "auto"
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_x = {
          {
            function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then return 'No LSP' end
              local names = {}
              for _, client in ipairs(clients) do
                table.insert(names, client.name)
                end
                return 'LSP: ' .. table.concat(names, ', ')
                end,
                icon = '🚀',
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
