return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Das hast du schon
	config = function()
		-- Wir prüfen erst, ob Treesitter da ist
		local ok, configs = pcall(require, "nvim-treesitter.configs")
		if not ok then
			return
		end

		configs.setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},
		})
	end,
}
