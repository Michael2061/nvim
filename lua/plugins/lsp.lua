return {
  { 
    "williamboman/mason.nvim", 
    opts = { ui = { border = "rounded" } } -- Hier die "rounded" Optik hinzugefügt
  },
  { 
    "williamboman/mason-lspconfig.nvim", 
    opts = {
      -- Hier die erweiterte Liste für fast alle Sprachen
      ensure_installed = { 
        "lua_ls", "pyright", "ts_ls", "html", "cssls", "jsonls", 
        "bashls", "rust_analyzer", "clangd", "gopls", "yamlls",
        "marksman", "dockerls", "sqlls"
      },
      automatic_installation = true, -- Installiert Server automatisch beim Öffnen
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      -- Hier müssen die neuen Server auch in die Liste, damit sie aktiviert werden
      local servers = { 
        "lua_ls", "pyright", "ts_ls", "html", "cssls", "jsonls", 
        "bashls", "rust_analyzer", "clangd", "gopls", "yamlls",
        "marksman", "dockerls", "sqlls" 
      }
      
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      for _, server in ipairs(servers) do
        -- Native 0.11 API Konfiguration
        vim.lsp.config(server, {
          install = {
            cmd = function(dispatchers)
              return require('lspconfig.configs.' .. server).default_config.cmd
            end
          },
          options = {
            capabilities = capabilities,
          }
        })
        -- Aktiviert den Server
        vim.lsp.enable(server)
      end

      -- Keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          -- Tipp: Füge noch 'gr' für Referenzen hinzu
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        end,
      })
    end
  }
}