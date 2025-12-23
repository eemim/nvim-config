return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000, -- make sure colorscheme loads early
	config = function()
		-- Step 1: setup with your custom overrides
		require("kanagawa").setup({
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = { -- add/modify theme and palette colors
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors) -- add/modify highlights
				local theme = colors.theme
				local var = "#C0A36E" -- boatYellow2: distinct, warm, readable

				local highlights = {
					-- Your local highlights
					["@variable"] = { fg = var },
					["@variable.builtin"] = { fg = var, italic = true },
					["@field"] = { fg = var },
					["@parameter"] = { fg = colors.palette.dragonGray },
					Identifier = { fg = var },

					-- nvim-cmp highlights
					CmpBorder = { fg = colors.palette.oldWhite, bg = colors.palette.sumiInk1 },
					CmpPmenu = { fg = colors.palette.oldWhite, bg = colors.palette.sumiInk1 },
					CmpPmenuSel = { fg = colors.palette.oldWhite, bg = colors.palette.waveBlue2 },
					CmpDocBorder = { fg = colors.palette.oldWhite, bg = colors.palette.sumiInk1 },
					CmpDoc = { fg = colors.palette.oldWhite, bg = colors.palette.sumiInk1 },

					-- Transparent floating windows (fixes FTerm black padding)
					NormalFloat = { bg = "none" },
					FloatBorder = { fg = theme.ui.special, bg = "none" },
					FloatTitle = { fg = theme.ui.special, bg = "none" },

					-- Optional darker background for certain windows
					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
				}

				return highlights
			end,
			theme = "dragon", -- Load "wave" theme
			background = { -- map the value of 'background' option to a theme
				dark = "dragon", -- try "dragon" !
				light = "lotus",
			},
		})

		-- Step 2: load the colorscheme
		require("kanagawa").load("dragon")
	end,
}
