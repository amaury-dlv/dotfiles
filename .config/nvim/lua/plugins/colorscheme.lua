return {
  {
    'p00f/alabaster.nvim',
    enabled = false,
    priority = 1000, -- Load colorscheme before other plugins
    config = function()
      vim.cmd.colorscheme('alabaster')
    end,
  },
  {
    'olimorris/onedarkpro.nvim',
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('onedark')
    end,
  },
  {
    'catppuccin/nvim',
    enabled = true,
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('catppuccin')
    end,
  },
}
