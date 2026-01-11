return {
  {
    "williamboman/mason.nvim",
    opts = { ui = { border = "rounded" } }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls", "pyright", "ts_ls", "html", "cssls", "jsonls",
        "bashls", "rust_analyzer", "clangd", "gopls", "yamlls",
        "marksman", "dockerls", "sqlls"
      },
      automatic_installation = true,
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    config = function()
    local servers = {
      "lua_ls", "pyright", "ts_ls", "html", "cssls", "jsonls",
      "bashls", "rust_analyzer", "clangd", "gopls", "yamlls",
      "marksman", "dockerls", "sqlls"
    }

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    for _, server in ipairs(servers) do
      -- Hier erstellen wir die Optionen für den Server
      local server_opts = {
        capabilities = capabilities,
      }

      -- SPEZIELLER FIX FÜR CSS (Waybar @color Variablen)
      if server == "cssls" then
        server_opts.settings = {
          css = { lint = { unknownAtRules = "ignore" } }
        }
        end

        -- Native 0.11 API Konfiguration
        vim.lsp.config(server, {
          install = {
            cmd = function(dispatchers)
            return require('lspconfig.configs.' .. server).default_config.cmd
            end
          },
          options = server_opts, -- Hier werden unsere Einstellungen (inkl. CSS Fix) übergeben
        })

        vim.lsp.enable(server)
        end

        -- 1. Keymaps & Diagnostics Fix
        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          -- Manueller Shortcut für Fehler-Fenster
          vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
          end,
        })

        -- 2. AUTOMATISCHES FEHLER-FENSTER (CursorHold)
        vim.api.nvim_create_autocmd("CursorHold", {
          callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
          }
          vim.diagnostic.open_float(nil, opts)
          end
        })

        -- 3. Geschwindigkeit der Anzeige anpassen (300ms statt 4s)
        vim.opt.updatetime = 300
        end
  }
}
