return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")
		local Terminal = require("toggleterm.terminal").Terminal

		-- =========================
		-- ToggleTerm setup
		-- =========================

		toggleterm.setup({
			open_mapping = nil,
			start_in_insert = true,
			insert_mappings = false,
			terminal_mappings = false,
			persist_size = true,
			close_on_exit = false,
			shade_terminals = false,

			size = function(term)
				if term.direction == "horizontal" then
					return math.floor(vim.o.lines * 0.3)
				elseif term.direction == "vertical" then
					return math.floor(vim.o.columns * 0.35)
				end
			end,

			float_opts = {
				border = "rounded",
				winblend = 25, -- glow illusion
				width = function()
					return math.floor(vim.o.columns * 0.5)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.5)
				end,
			},
		})

		-- =========================
		-- Retro CRT palette
		-- =========================

		local crt_bg = "#0b0e14" -- NOT pure black → glow illusion

		-- Floating: green phosphor
		vim.api.nvim_set_hl(0, "ToggleTermFloat", {
			fg = "#33ff33",
			bg = crt_bg,
		})
		vim.api.nvim_set_hl(0, "ToggleTermFloatBorder", {
			fg = "#55ff55", -- slightly brighter → glow edge
			bg = crt_bg,
		})

		-- Horizontal: amber terminal
		vim.api.nvim_set_hl(0, "ToggleTermHoriz", {
			fg = "#ffb000",
			bg = crt_bg,
		})

		-- Vertical: cyan hacker terminal
		vim.api.nvim_set_hl(0, "ToggleTermVert", {
			fg = "#00ffff",
			bg = crt_bg,
		})

		-- =========================
		-- on_open hooks (PER WINDOW)
		-- =========================

		local function float_open(term)
			vim.cmd("startinsert!")
			vim.api.nvim_buf_set_option(
				term.bufnr,
				"winhighlight",
				"Normal:ToggleTermFloat,FloatBorder:ToggleTermFloatBorder"
			)
		end

		local function horiz_open(term)
			vim.cmd("startinsert!")
			vim.api.nvim_buf_set_option(term.bufnr, "winhighlight", "Normal:ToggleTermHoriz")
		end

		local function vert_open(term)
			vim.cmd("startinsert!")
			vim.api.nvim_buf_set_option(term.bufnr, "winhighlight", "Normal:ToggleTermVert")
		end

		-- =========================
		-- Terminal instances
		-- =========================

		local float_term = Terminal:new({
			direction = "float",
			hidden = true,
			on_open = float_open,
		})

		local horiz_term = Terminal:new({
			direction = "horizontal",
			hidden = true,
			on_open = horiz_open,
		})

		local vert_term = Terminal:new({
			direction = "vertical",
			hidden = true,
			on_open = vert_open,
		})

		-- =========================
		-- Keymaps
		-- =========================

		vim.keymap.set({ "n", "t" }, "<A-i>", function()
			float_term:toggle()
		end, { desc = "Toggle floating terminal" })

		vim.keymap.set({ "n", "t" }, "<A-h>", function()
			horiz_term:toggle()
		end, { desc = "Toggle horizontal terminal" })

		vim.keymap.set({ "n", "t" }, "<A-v>", function()
			vert_term:toggle()
		end, { desc = "Toggle vertical terminal" })

		-- Kill ONLY the active terminal
		vim.keymap.set("t", "<A-x>", function()
			local buf = vim.api.nvim_get_current_buf()
			if buf == float_term.bufnr then
				float_term:shutdown()
			elseif buf == horiz_term.bufnr then
				horiz_term:shutdown()
			elseif buf == vert_term.bufnr then
				vert_term:shutdown()
			end
		end, { desc = "Kill active terminal" })

		-- Exit terminal mode (keep it open)
		vim.keymap.set("t", "<C-x>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
	end,
}
