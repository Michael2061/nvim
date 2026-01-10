return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      -- DAS WICHTIGE PLUGIN FÜR AUTOMATISIERUNG:
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local mason_dap = require("mason-nvim-dap")

      -- 1. Mason-DAP Setup (Installiert die Adapter automatisch)
      mason_dap.setup({
        -- Hier die Liste der Adapter, die du haben willst:
        ensure_installed = { 
          "python", 
          "delve",   -- für Go
          "codelldb", -- für C, C++, Rust
          "bash",
        },
        automatic_installation = true,
        -- Verknüpft die Mason-Installation automatisch mit DAP-Konfigurationen
        handlers = {}, 
      })

      -- 2. DAP UI Setup
      dapui.setup()

      -- Icons verschönern (Roter Punkt für Breakpoints)
      vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='', linehl='', numhl='' })
      vim.fn.sign_define('DapStopped', { text='▶️', texthl='', linehl='', numhl='' })

      -- UI automatisch öffnen/schließen
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- Keymaps
      vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "Debug: Start/Continue" })
      vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
    end,
  },
  -- Helfer-Plugins für einfachere Konfiguration
  { "mfussenegger/nvim-dap-python", ft = "python", config = function() require("dap-python").setup("python") end },
  { "leoluz/nvim-dap-go", ft = "go", config = function() require("dap-go").setup() end },
}