return {
	{
		"williamboman/mason.nvim",
		opts = { ui = { border = "rounded" } },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"ruff", -- 1. HIER HINZUGEFÜGT: Damit Mason Ruff automatisch installiert
				"ts_ls",
				"html",
				"cssls",
				"jsonls",
				"bashls",
				"rust_analyzer",
				"clangd",
				"gopls",
				"yamlls",
				"marksman",
				"dockerls",
				"sqlls",
			},
			automatic_installation = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
		local servers = {
			"lua_ls",
			"pyright",
			"ruff", -- 2. HIER HINZUGEFÜGT: Damit die Schleife unten Ruff aktiviert
			"ts_ls",
			"html",
			"cssls",
			"jsonls",
			"bashls",
			"rust_analyzer",
			"clangd",
			"gopls",
			"yamlls",
			"marksman",
			"dockerls",
			"sqlls",
		}

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		for _, server in ipairs(servers) do
			local server_opts = {
				capabilities = capabilities,
			}

			-- =============================================================
			-- SPEZIELLE SERVER-EINSTELLUNGEN (FIXES)
			-- =============================================================

			-- 3. HIER HINZUGEFÜGT: Spezielle Logik für Ruff
			if server == "ruff" then
				-- Verhindert, dass Ruff mit Pyright kollidiert, wenn beide Hover-Infos anzeigen
				server_opts.on_attach = function(client, bufnr)
				-- Wir lassen Ruff das Hovern (K) deaktivieren, da Pyright das oft besser kann
				client.server_capabilities.hoverProvider = false
				end
				end

				if server == "lua_ls" then
					server_opts.settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							intl = { locale = "en-us" },
						},
					}
					end

					if server == "cssls" then
						server_opts.settings = {
							css = { lint = { unknownAtRules = "ignore" } },
						}
						end

						if server == "pyright" then
							server_opts.settings = {
								python = { analysis = { autoSearchPaths = true, useLibraryCodeForTypes = true } },
							}
							end

							-- =============================================================

							-- Native 0.11 API Konfiguration
							vim.lsp.config(server, {
								install = {
									cmd = function()
									return require("lspconfig.configs." .. server).default_config.cmd
									end,
								},
								options = server_opts,
							})

							vim.lsp.enable(server)
							end

							-- Keymaps & Diagnostics Fix (Bleibt wie es ist)
							vim.api.nvim_create_autocmd("LspAttach", {
								callback = function(ev)
								local opts = { buffer = ev.buf }
								vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
								vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
								vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
								vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
								end,
							})

							-- Automatisches Fehler-Fenster (Bleibt wie es ist)
							vim.api.nvim_create_autocmd("CursorHold", {
								callback = function()
								local opts = {
									focusable = false,
									close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
									border = "rounded",
									source = "always",
									scope = "cursor",
								}
								vim.diagnostic.open_float(nil, opts)
								end,
							})

							vim.opt.updatetime = 300
							end,
	},
}
