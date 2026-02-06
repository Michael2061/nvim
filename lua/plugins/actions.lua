return {
	{
		"aznhe21/actions-preview.nvim",
		config = function()
			require("actions-preview").setup({
				-- Hier kannst du das Aussehen anpassen
				backend = { "telescope", "nui" }, -- Nutzt Telescope für die Auswahl
				telescope = {
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
					layout_config = {
						width = 0.8,
						height = 0.9,
						prompt_position = "top",
						preview_cutoff = 20,
						preview_height = 0.5,
					},
				},
			})
		end,
	},
}
