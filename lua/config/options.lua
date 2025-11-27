local opt = vim.opt

opt.number = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.termguicolors = true

vim.opt.clipboard = "unnamedplus"
-- Clipboard setup for WSL / Linux
--if vim.fn.executable("clip.exe") == 1 then
--  vim.opt.clipboard = "unnamedplus"
--else
--  vim.opt.clipboard = ""
--end
