return {
	-- Hardtime: Zwingt dich zur Vim-Navigation
	--	{
	--		"m4xshen/hardtime.nvim",
	--		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	--		opts = {
	--			max_time = 1000,
	--			max_count = 999999990,
	--			allow_different_key = true,
	--			disabled_keys = {
	--				["<Up>"] = {},
	--				["<Down>"] = {},
	--				["<Left>"] = {},
	--				["<Right>"] = {},
	--				["j"] = {}, -- Erlaubt langes Drücken von j
	--				["k"] = {}, -- Erlaubt langes Drücken von k
	--			},
	--			disabled_modes = { "i", "v" },
	--		},
	--	},

	-- Screenkey: Zeigt deine Tastendrücke visuell an
	{
		"NStefan002/screenkey.nvim",
		lazy = false,
		opts = {
			win_opts = {
				border = "rounded",
			},
			show_leader = true,
		},
		config = function(_, opts)
			require("screenkey").setup(opts)

			-- Verbesserte Logik: Startet Screenkey nur in echten Dateien, NICHT im Dashboard
			vim.api.nvim_create_autocmd("BufReadPost", {
				callback = function()
					local ft = vim.bo.filetype
					-- Liste der Dateitypen, bei denen Screenkey AUS bleiben soll
					local ignore_ft = { "dashboard", "alpha", "starter", "neo-tree", "TelescopePrompt" }

					local is_ignored = false
					for _, v in ipairs(ignore_ft) do
						if ft == v then
							is_ignored = true
							break
						end
					end

					-- Nur starten, wenn keine Ignorier-Datei UND Dateiname vorhanden ist
					if not is_ignored and vim.fn.expand("%") ~= "" then
						-- pcall verhindert Fehlermeldungen, falls Screenkey schon läuft
						pcall(function()
							vim.cmd("Screenkey")
						end)
					end
				end,
			})

			-- Die Keymap zum manuellen Umschalten
			vim.keymap.set("n", "<leader>sk", "<cmd>Screenkey toggle<cr>", { desc = "Tastatur-Anzeige an/aus" })
		end,
	},
}
