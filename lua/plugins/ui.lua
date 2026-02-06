return {
	-- 1. THEME: ROSE-PINE
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "main", -- oder "moon" für dein Arch-Setup
				styles = {
					italic = true,
					transparency = true, -- Wichtig für den transparenten Arch-Look
				},
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},

	-- 2. TREESITTER
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		priority = 1000,
		config = function()
			local status_ok, configs = pcall(require, "nvim-treesitter.configs")
			if not status_ok then
				return
			end

			configs.setup({
				ensure_installed = {
					"python",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"bash",
					"markdown",
					"markdown_inline",
					"regex",
					"css",
					"html",
					"javascript",
					"latex",
					"scss",
					"sql",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				-- WICHTIG: Falls das automatische Löschen von Leerzeilen nervt,
				-- kannst du indent hier auf false setzen oder testen:
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
		dependencies = { "echasnovski/mini.icons" }, -- Hinzugefügt, um Warnung zu beheben
		opts = {
			options = {
				icons_enabled = true,
				theme = "rose-pine", -- GEÄNDERT: Von tokyonight auf rose-pine
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_x = {
					{
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if #clients == 0 then
								return "No LSP"
							end
							local names = {}
							for _, client in ipairs(clients) do
								table.insert(names, client.name)
							end
							return "LSP: " .. table.concat(names, ", ")
						end,
						icon = "🚀",
						-- GEÄNDERT: fg auf ein sanftes Rosé-Violett angepasst
						color = { fg = "#c4a7e7", gui = "bold" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		},
	},

	-- 5. MINI.ICONS (Behebt die Which-Key Warnung)
	{ "echasnovski/mini.icons", opts = {} },
}
