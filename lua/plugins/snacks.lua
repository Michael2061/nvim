return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = function()
		return {
			dashboard = {
				enabled = true,
				sections = {
					-- 1. DEIN LOGO (Terminal-Emulation)
					{
						section = "terminal",
						cmd = [[echo "           .
          . .
        ... ..
     ..   ..  ..
    ..     ..  ..
   ..       ..  ..
   ..            ..
    ..          ..
     ..        ..
      ..      ..
        ..  ..
          .."]],
						height = 10,
						padding = 2,
						indent = 2,
					},
					-- 2. SCHNELLSTART-TASTEN
					{ section = "keys", gap = 1, padding = 1 },
					-- 3. VERLAUF
					{ section = "recent_files", indent = 2, padding = 1 },
					-- 4. STARTUP ZEIT
					{ section = "startup" },
				},
			},
			-- Andere Module aktiv halten
			notifier = { enabled = true, style = "fancy" },
			explorer = { enabled = true },
			picker = { enabled = true },
			indent = { enabled = true, char = "│" },
			input = { enabled = true },
			scope = { enabled = true },
			words = { enabled = true },
		}
	end,
	-- Deine Keymaps
	keys = {
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "LazyGit",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Notizen",
		},
	},
}
