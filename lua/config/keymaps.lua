local map = vim.keymap.set

-- Buffers
map("n", "<leader>w", ":w<CR>", { desc = "Write buffer" })
map("n", "<leader>x", ":bd<CR>", { desc = "Delete buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
local function smart_buffer_delete()
	local bufnr = vim.api.nvim_get_current_buf()

	-- If it's the last buffer: just wipe it and leave nvim open
	if #vim.fn.getbufinfo({ buflisted = 1 }) == 1 then
		vim.cmd("bd")
		return
	end

	-- Switch to the previous buffer
	vim.cmd("bp")

	-- Now delete the original buffer
	vim.cmd("bd " .. bufnr)
end

vim.keymap.set("n", "<leader>x", smart_buffer_delete, { desc = "Delete buffer safely" })

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
