return {
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "stevearc/overseer.nvim",
    opts = {
      templates = { "builtin", "user.gradle", "user.gradle-configure" },
    },
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      padding = false,
      -- toggler = {
      --   ---Line-comment toggle keymap
      --   line = nil,
      -- },
      ---Enable keybindings
      ---NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      },
    }
  }
}
