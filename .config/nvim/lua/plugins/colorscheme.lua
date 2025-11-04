return {
  'p00f/alabaster.nvim',
  priority = 1000, -- Load colorscheme before other plugins
  config = function()
    vim.cmd.colorscheme('alabaster')
  end,
}
