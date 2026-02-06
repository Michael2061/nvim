return {
{
    "williamboman/mason.nvim",
    cmd = "Mason", -- Das erzwingt, dass der Befehl registriert wird
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },

    {
		"neovim/nvim-lspconfig",
		config = function()
			-- Die Liste deiner Server
			local servers = { "lua_ls", "pyright", "bashls", "rust_analyzer" }

			for _, lsp in ipairs(servers) do
				-- Die NEUE Syntax für Neovim 0.11+
				-- Wir nutzen vim.lsp.config anstatt require('lspconfig')
				if vim.lsp.config then
					vim.lsp.config(lsp, {
						-- Deine Einstellungen hier
					})
				else
					-- Fallback für ältere Versionen
					require("lspconfig")[lsp].setup({})
				end
			end

			-- WICHTIG: Die Server müssen trotzdem noch "gestartet" werden
			-- nvim-lspconfig macht das meist automatisch, wenn man die Plugins lädt.
		end,
	},
}
