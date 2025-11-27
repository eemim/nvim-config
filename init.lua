vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

require("config.lazy")
require("config.options")
require("config.keymaps")
require("lsp")

vim.diagnostic.config({ virtual_lines = true })
