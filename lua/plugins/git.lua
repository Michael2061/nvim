return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        -- Zeichen in der "Gutter" (links neben der Zeilennummer)
        signs = {
          add          = { text = '+' },
          change       = { text = '~' },
          delete       = { text = '-' },
          topdelete    = { text = '‾' },
          changedelete = { text = '≃' },
          untracked    = { text = '?' },
        },
        -- Zeigt eine Vorschau der Änderung in einer kleinen Sprechblase (Blame)
        current_line_blame = true, 
        current_line_blame_opts = {
          delay = 500,
        },
        
        -- Praktische Tastenkombinationen nur für Git
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation zwischen Änderungen (Hunks)
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = "Nächste Änderung" })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = "Vorherige Änderung" })

          -- Aktionen
          map('n', '<leader>hp', gs.preview_hunk, { desc = "Vorschau Änderung" })
          map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Git Blame" })
          map('n', '<leader>hr', gs.reset_hunk, { desc = "Änderung rückgängig" })
        end
      })
    end
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<CR>', { desc = "Git Diff Ansicht" })
      vim.keymap.set('n', '<leader>gc', ':DiffviewClose<CR>', { desc = "Git Diff schließen" })
    end
  }
}