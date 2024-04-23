return {
  { "tpope/vim-fugitive" },
  {
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        vim.keymap.set("n", "<leader>ex", require("substitute").operator, { noremap = true, desc = "Substitute" }),
        --vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
        --vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
        vim.keymap.set("x", "<leader>ex", require("substitute").visual, { noremap = true, desc = "Substitute" }),
      })
    end,
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>e"] = { name = "+editor" }
    end,
  },
  {
    "glacambre/firenvim",
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },
}
