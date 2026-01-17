return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- 1. DASHBOARD DEAKTIVIEREN (Löst den Konflikt mit dashboard-nvim)
		dashboard = { enabled = false },

		-- 2. RESTLICHE OPTIONEN BEIBEHALTEN
		indent = { enabled = true, char = "│" },
		notifier = { enabled = true, timeout = 3000 },
		input = { enabled = true },
		styles = {
			notification = {
				wo = { wrap = true },
			},
		},
	},
	keys = {
		{
			"<leader>.",
			function()
			Snacks.scratch()
			end,
			desc = "Projekt Notizen",
		},
		{
			"<leader>S",
			function()
			Snacks.scratch.select()
			end,
			desc = "Alle Notizen durchsuchen",
		},
		{
			"<leader>nh",
			function()
			Snacks.notifier.show_history()
			end,
			desc = "Benachrichtigungs-Verlauf",
		},
		{
			"<leader>bd",
			function()
			Snacks.bufdelete()
			end,
			desc = "Buffer schließen",
		},
		{
			"<leader>gg",
			function()
			Snacks.lazygit()
			end,
			desc = "LazyGit",
		},
	},
}
