return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			local toggleterm = require("toggleterm")
			toggleterm.setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					else
						return 20
					end
				end,
				hide_numbers = true,
				start_in_insert = true,
				shade_terminals = true,
				direction = "float",
				float_opts = {
					border = "rounded",
				},
			})

			local Terminal = require("toggleterm.terminal").Terminal

			local horizontal = Terminal:new({ direction = "horizontal", close_on_exit = true })
			local vertical = Terminal:new({ direction = "vertical", close_on_exit = true })
			local float = Terminal:new({ direction = "float", close_on_exit = true })

			-- mappings: work in normal and terminal mode
			local keymap = vim.keymap.set
			keymap({ "n", "t" }, "<A-h>", function()
				horizontal:toggle()
			end, { desc = "Toggle horizontal terminal" })
			keymap({ "n", "t" }, "<A-v>", function()
				vertical:toggle()
			end, { desc = "Toggle vertical terminal" })
			keymap({ "n", "t" }, "<A-i>", function()
				float:toggle()
			end, { desc = "Toggle floating terminal" })

			-- Terminal-mode: exit "insert" (terminal) to normal with Ctrl-x
			keymap("t", "<C-x>", [[<C-\><C-n>]], { silent = true })

			-- Smart buffer delete function
			local function smart_buffer_delete()
				local bufnr = vim.api.nvim_get_current_buf()
				local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")

				-- If terminal, force delete
				if buftype == "terminal" then
					vim.cmd("bd!")
					return
				end

				-- If it's the last buffer, just wipe it
				if #vim.fn.getbufinfo({ buflisted = 1 }) == 1 then
					vim.cmd("bd")
					return
				end

				-- Switch to previous buffer and delete original
				vim.cmd("bp")
				vim.cmd("bd " .. bufnr)
			end

			-- Map <leader>x in both normal and terminal mode
			keymap("n", "<leader>x", smart_buffer_delete, { desc = "Delete buffer safely" })
			keymap("t", "<leader>x", smart_buffer_delete, { desc = "Delete terminal buffer safely" })
		end,
	},
}
