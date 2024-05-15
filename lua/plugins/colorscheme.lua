return {
  -- add gruvbox
  --{ "ellisonleao/gruvbox.nvim" },
  { "morhetz/gruvbox" },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      --https://github.com/folke/tokyonight.nvim/issues/34#issuecomment-1347911154
      on_colors = function(colors)
        colors.border = "#565f89"
      end,
    },
  },
  -- Configure LazyVim to load gruvbox
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "catppuccin",
  --   },
  -- },
}
