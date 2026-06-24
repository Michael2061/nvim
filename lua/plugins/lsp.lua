return {
{
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },

    {
		"neovim/nvim-lspconfig",
		config = function()
			local servers = { "lua_ls", "pyright", "bashls", "rust_analyzer" }

			local on_attach = function(client, bufnr)
				local bufopts = { silent = true, buffer = bufnr }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "Gehe zur Definition" }))
				vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "Hover Info" }))
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", bufopts, { desc = "Gehe zur Implementation" }))
				vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "Zeige Referenzen" }))
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "Umbenennen" }))


			end

			for _, lsp in ipairs(servers) do
				if vim.lsp.config then
					vim.lsp.config(lsp, {
						on_attach = on_attach,
					})
				else
					require("lspconfig")[lsp].setup({
						on_attach = on_attach,
					})
				end
			end
		end,
	},
}
