vim.cmd.source('~/.vimrc')

vim.g.mapleader = " "
vim.g.localmapleader = " "

vim.g.have_nerd_font = true

vim.o.mouse = "a"             -- Enable mouse mode
vim.o.inccommand="split"      -- preview substitutions live
vim.o.splitright=true         -- new hsplits open on the right
vim.o.splitbelow=true         -- new vsplits open below
vim.o.breakindent = true      -- Preserve indentation on line wrapping
vim.o.undofile = true         -- Save undo history

vim.opt.shortmess:append('WaoOtTAI') -- Use abbrevations when possible

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
     [vim.diagnostic.severity.ERROR] = '●',
     [vim.diagnostic.severity.WARN] = '●',
     [vim.diagnostic.severity.HINT] = '●',
     [vim.diagnostic.severity.INFO] = '●',
    },
  },
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear search highlight
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" }) -- Show diagnostics
vim.keymap.set("n", ",l", function() vim.o.number = not vim.o.number end, { desc = "Toggle line numbers" })
vim.keymap.set("n", ",c", "<cmd>tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "L", "gt", { desc = "Next tab" })
vim.keymap.set("n", "H", "gT", { desc = "Previous tab" })

-- Yank to system clipboard (delete/change operations stay in vim registers)
vim.keymap.set({"n", "v"}, "y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

--  Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Load all plugins from lua/plugins/*.lua
require("lazy").setup("plugins")

-- Restore pane navigation (override snacks.nvim defaults)
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left pane' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to down pane' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to up pane' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right pane' })

-- vim: ts=2 sts=2 sw=2 et
