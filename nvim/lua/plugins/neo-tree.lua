return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false,
		config = function()
			require("neo-tree").setup({
				enable_git_status = true,
				enable_diagnostics = true,
				window = {
					mappings = {
						["<Tab>"] = "toggle_node",
						["s"] = "open_with_window_picker",
						["v"] = "vsplit_with_window_picker",
						["S"] = "split_with_window_picker",
					},
				},
			})
		end,
	},
}
