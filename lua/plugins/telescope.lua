return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup{
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
          require("telescope.themes").get_dropdown{}
        }
      },
    }

    -- Optional: FZF extension
    pcall(function()
      telescope.load_extension("fzf", "ui-select")
    end)
  end,
}
