local map = vim.keymap.set

map("n", "<leader>w", ":w<CR>", { desc = "Write buffer" })
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>x", ":bd<CR>", { desc = "Delete buffer" })

-- Better window navigation (like NvChad)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Telescope keymaps
map("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find Files" })
map("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live Grep" })
map("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Buffers" })
map("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Help Tags" })
map("n", "<leader>gs", require("telescope.builtin").git_status, { desc = "Git Status" })

-- NvimTree keymaps
map("n", "<C-n>", ":NvimTreeToggle<CR>", {})

-- Formatting
map("n", "<leader>f", function()
	require("conform").format({ async = true }, function()
		vim.notify("Formatted!", vim.log.levels.INFO)
	end)
end, { desc = "Format current file" })

-- Kanagawa
map("n", "<leader>th", ":KanagawaCompile<CR>", { desc = "Kanagawa compiled" })

-- Dashboard
map("n", "<leader>db", ":Dashboard<CR>", { desc = "Dashboard" })
