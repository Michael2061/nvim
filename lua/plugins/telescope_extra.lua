return {
	"debugloop/telescope-undo.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	keys = {
		{ "<leader>uu", "<cmd>Telescope undo<cr>", desc = "Undo Zeitmaschine" },
	},
	config = function()
		require("telescope").load_extension("undo")
	end,
}
