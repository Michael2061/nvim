return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000, -- Muss vor allem anderen geladen werden
		config = function()
			require("rose-pine").setup({
				variant = "auto", -- "main", "moon", oder "dawn" (hell)
				dark_variant = "main", -- oder "moon" für etwas mehr Blau-Grau
				styles = {
					italic = true,
					transparency = true, -- WICHTIG: Damit dein Arch-Wallpaper durchscheint!
				},
			})

			-- Hier wird das Theme aktiviert
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
