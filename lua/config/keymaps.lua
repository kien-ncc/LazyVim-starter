-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<BS>", "<C-o>")
vim.keymap.set("n", "<F5>", "<cmd>checktime<CR>", { noremap = true })
vim.keymap.set("n", "<C-Tab>", "<leader>fb", { noremap = true })
