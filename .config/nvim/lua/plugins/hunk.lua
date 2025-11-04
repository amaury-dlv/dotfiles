-- Git hunk management
return {
  "julienvincent/hunk.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  cmd = { "DiffEditor" },
  config = function()
    local hunk = require("hunk")
    hunk.setup({
      keys = {
        global = {
          quit = { "q" },
          accept = { "<leader><Cr>" },
          focus_tree = { "<leader>e" },
        },

        tree = {
          expand_node = { "l", "<Right>" },
          collapse_node = { "h", "<Left>" },

          open_file = { "<Cr>" },

          toggle_file = { "a" },
        },

        diff = {
          toggle_hunk = { "A" },
          toggle_line = { "a" },
          -- This is like toggle_line but it will also toggle the line on the other
          -- 'side' of the diff.
          toggle_line_pair = { "s" },

          prev_hunk = { "[h" },
          next_hunk = { "]h" },

          -- Jump between the left and right diff view
          toggle_focus = { "<Tab>" },
        },
      },

      ui = {
        tree = {
          -- Mode can either be `nested` or `flat`
          mode = "flat",
          width = 35,
        },
        --- Can be either `vertical` or `horizontal`
        layout = "vertical",
      },

      icons = {
        selected = "󰡖",
        deselected = "",
        partially_selected = "󰛲",

        folder_open = "",
        folder_closed = "",
      },

      -- Called right after each window and buffer are created.
      hooks = {
        ---@param _context { buf: number, tree: NuiTree, opts: table }
        on_tree_mount = function(_context) end,
        ---@param _context { buf: number, win: number }
        on_diff_mount = function(_context) end,
      },
    })

    -- Define Red and Green highlight groups that hunk.nvim expects
    vim.api.nvim_set_hl(0, "Red", { fg = "#e06c75" })
    vim.api.nvim_set_hl(0, "Green", { fg = "#98c379" })
  end,
}
