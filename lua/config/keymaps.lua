-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<BS>", "<C-o>")
vim.keymap.set("n", "<F5>", "<cmd>checktime<CR>", { noremap = true })
-- vim.keymap.set("n", "<C-Tab>", "<leader>fb", { noremap = true })
vim.keymap.set("n", "<C-Tab>", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { noremap = true })
vim.keymap.del("n", "H")
vim.keymap.set("x", "S", [[:<C-u>lua require('mini.surround').add('visual')<CR>]], { silent = true })
vim.keymap.set(
  "n",
  "<leader>fo",
  "<cmd>Neotree toggle show document_symbols reveal<CR>",
  { noremap = true, desc = "File outline" }
)
