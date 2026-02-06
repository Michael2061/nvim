return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "rose-pine", -- HIER die Änderung vornehmen
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			-- Deine restlichen Sektionen bleiben gleich
		})
	end,
}
