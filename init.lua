--vim.opt.termguicolors = false
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
if vim.g.shadowvim then
  -- ShadowVim-specific statements
  return
end

-- if not vim.g.neovide then
--   vim.opt.termguicolors = false
--   --vim.opt.background = "light"
--   vim.cmd("colorscheme fu")
-- end
