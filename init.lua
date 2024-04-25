--vim.opt.termguicolors = false
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
if vim.g.shadowvim then
  -- ShadowVim-specific statements
  return
end
-- MiniSurround
-- Remap adding surrounding to Visual mode selection
-- vim.keymap.del("x", "ys")
-- vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

-- if not vim.g.neovide then
--   vim.opt.termguicolors = false
--   --vim.opt.background = "light"
--   vim.cmd("colorscheme fu")
-- end
