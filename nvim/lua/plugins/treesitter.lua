return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  -- optional: tells lazy.nvim to run :TSUpdate after installing/updating
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "python",
      "bash",
      "markdown",
      "markdown_inline",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "ruby",
      "go",
      "gomod",
      "gowork",
      "gosum",
    },
    highlight = {
      enable = true,                    -- enable syntax highlighting
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },         -- optional: enable Treesitter-based indentation
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

