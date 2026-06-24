return {
	-- 1. THEME: ROSE-PINE
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "auto",
				dark_variant = "main",
				styles = {
					italic = true,
					transparency = true,
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
					"python", "lua", "vim", "vimdoc", "query",
					"bash", "markdown", "markdown_inline", "regex",
					"css", "html", "javascript", "latex", "scss", "sql",
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
		branch = "v3.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
		keys = {
			{ "<leader>e", ":Neotree toggle<CR>", desc = "Datei-Explorer", silent = true },
		},
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
		dependencies = { "echasnovski/mini.icons" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "rose-pine",
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
						icon = "",
						color = { fg = "#c4a7e7", gui = "bold" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		},
	},

	-- 5. MINI.ICONS
	{ "echasnovski/mini.icons", opts = {} },
}
