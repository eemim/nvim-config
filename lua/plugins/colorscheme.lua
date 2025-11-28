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
				-- variable color + sensible fallbacks
				local var = "#C0A36E" -- boatYellow2: distinct, warm, readable
				local highlights = {
					-- Treesitter groups
					["@variable"] = { fg = var },
					["@variable.builtin"] = { fg = var, italic = true },

					-- Common Treesitter/semantic/lightning aliases
					["@field"] = { fg = var },
					["@parameter"] = { fg = colors.palette.dragonGray },

					-- Non-Treesitter fallback
					Identifier = { fg = var },
				}

				-- Add nvim-cmp highlights
				highlights["CmpBorder"] = { fg = colors.palette.oldWhite, bg = colors.palette.sumiInk1 }
				highlights["CmpPmenu"] = { fg = colors.palette.oldWhite, bg = colors.palette.sumiInk1 }
				highlights["CmpPmenuSel"] = { fg = colors.palette.oldWhite, bg = colors.palette.waveBlue2 }
				highlights["CmpDocBorder"] = { fg = colors.palette.oldWhite, bg = colors.palette.sumiInk1 }
				highlights["CmpDoc"] = { fg = colors.palette.oldWhite, bg = colors.palette.sumiInk1 }

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
