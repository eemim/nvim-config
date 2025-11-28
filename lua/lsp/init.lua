local servers = {
	"lua_ls",
	"pyright",
	"marksman",
	"bashls",
	"ts_ls",
}

-- Load Mason LSPConfig integration
local mason_lsp = require("mason-lspconfig")
mason_lsp.setup({ ensure_installed = servers })

-- Load LuaSnip and friendly snippets
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

-- Setup nvim-cmp for completion
local cmp = require("cmp")
cmp.setup({
	-- UI windows
	window = {
		completion = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder,Search:None",
		}), -- uses FloatBorder + NormalFloat
		documentation = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder,Search:None",
		}),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
})

-- Setup each server
for _, name in ipairs(servers) do
	local opts = {}
	local ok, server_config = pcall(require, "lsp." .. name)
	if ok then
		opts = server_config
	end

	vim.lsp.config(
		name,
		vim.tbl_deep_extend("force", opts, {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
	)
end

-- Enable all servers with the new Neovim 0.10+ API
vim.lsp.enable(servers)
