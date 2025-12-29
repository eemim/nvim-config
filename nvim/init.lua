vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- vim.opt.splitright = true
-- vim.opt.splitbelow = true

-- -- Ruby on Rails setup
-- local gem_bin = os.getenv("HOME") .. "/.local/share/gem/ruby/3.2.0/bin"
-- vim.env.PATH = gem_bin .. ":" .. vim.env.PATH

require("config.lazy")
require("config.options")
require("config.keymaps")
require("lsp")

vim.diagnostic.config({ virtual_lines = true })

-- python3 host
vim.g.python3_host_prog = "/usr/bin/python3"
