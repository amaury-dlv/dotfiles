-- Adds git related signs to the gutter and git hunk navigation
return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add          = { text = '▎' },
      change       = { text = '▎' },
      delete       = { text = '󰍵' },
      topdelete    = { text = '▔' },
      changedelete = { text = '󱕖' },
      untracked    = { text = '▎' },
    },
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      -- Navigation
      vim.keymap.set('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({']c', bang = true})
        else
          gitsigns.nav_hunk('next')
        end
      end, {buffer = bufnr, desc = 'Next git hunk'})

      vim.keymap.set('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({'[c', bang = true})
        else
          gitsigns.nav_hunk('prev')
        end
      end, {buffer = bufnr, desc = 'Previous git hunk'})

      -- Actions
      vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, {buffer = bufnr, desc = '[H]unk [S]tage'})
      vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, {buffer = bufnr, desc = '[H]unk [R]eset'})
      vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, {buffer = bufnr, desc = '[H]unk [U]ndo stage'})
    end,
  },
}
