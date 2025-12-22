-- Treesitter for better syntax highlighting and code understanding
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "swift", "c", "cpp", "lua", "python", "vim", "vimdoc", "markdown", "css", "html", "javascript", "typescript" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable = true,
      max_lines = 3, -- How many lines of context to show
      min_window_height = 20,
    },
  },
}
