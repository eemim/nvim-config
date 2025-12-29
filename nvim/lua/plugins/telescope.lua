return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		telescope.setup({
			defaults = {
				selection_caret = "➤ ",
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					},
					n = {
						["q"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = { theme = "dropdown" },
				buffers = { show_all_buffers = true },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		-- Optional: FZF extension
		pcall(function()
			telescope.load_extension("fzf", "ui-select")
		end)

		-- =========================
		-- Keymaps with delete
		-- =========================

		-- Terminal buffers
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local previewers = require("telescope.previewers")
		local conf = require("telescope.config").values

		local function find_term_buffers()
			local bufs = {}
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "terminal" then
					table.insert(bufs, buf)
				end
			end

			pickers
				.new({}, {
					prompt_title = "Terminal Buffers",
					finder = finders.new_table({
						results = bufs,
						entry_maker = function(buf)
							return {
								value = buf,
								display = vim.api.nvim_buf_get_name(buf) ~= "" and vim.api.nvim_buf_get_name(buf)
									or "[terminal]",
								ordinal = vim.api.nvim_buf_get_name(buf),
							}
						end,
					}),
					sorter = conf.generic_sorter({}),
					-- <<< Add this previewer
					previewer = previewers.new_buffer_previewer({
						define_preview = function(self, entry, status)
							local buf = entry.value
							-- Show first 50 lines of the terminal buffer (or less)
							local lines = vim.api.nvim_buf_get_lines(buf, 0, 50, false)
							vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
						end,
					}),
					-- <<< end previewer
					attach_mappings = function(prompt_bufnr, map)
						local delete_buf = function()
							local selection = action_state.get_selected_entry()
							actions.close(prompt_bufnr)
							vim.api.nvim_buf_delete(selection.value, { force = true })
						end

						map("i", "<C-d>", delete_buf)
						map("n", "<C-d>", delete_buf)

						map("i", "<CR>", function()
							local selection = action_state.get_selected_entry()
							actions.close(prompt_bufnr)
							vim.api.nvim_set_current_buf(selection.value)
						end)
						map("n", "<CR>", function()
							local selection = action_state.get_selected_entry()
							actions.close(prompt_bufnr)
							vim.api.nvim_set_current_buf(selection.value)
						end)

						return true
					end,
				})
				:find()
		end

		-- Map keys
		vim.keymap.set("n", "<leader>ft", find_term_buffers, { desc = "Find terminal buffers" })
	end,
}
