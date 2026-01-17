return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
				-- Anstatt des fehlerhaften Terminal-Befehls zeigen wir hier
				-- lieber deine zuletzt geöffneten Dateien an
				{ section = "recent_files", title = "󰄉 Letzte Dateien", indent = 2, padding = 1 },
				{ section = "projects", title = "󰉋 Projekte", indent = 2, padding = 1 },
			},
			header = [[
   ______           __             ____  _____
  / ____/___ ______/ /_  __  __   / __ \/ ___/
 / /   / __ `/ ___/ __ \/ / / /  / / / /\__ \ 
/ /___/ /_/ / /__/ / / / /_/ /  / /_/ /___/ / 
\____/\__,_/\___/_/ /_/\__, /   \____//____/  
                      /____/                   ]],
		},
		indent = { enabled = true, char = "│" },
		notifier = { enabled = true, timeout = 3000 },
		input = { enabled = true },
	},
	keys = {
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Notizzettel (Scratchpad)",
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
