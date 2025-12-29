return {
	settings = {
		gopls = {
			gofumpt = true,
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
			analyses = {
				unusedparams = true,
				nilness = true,
				shadow = true,
			},
		},
	},
}
