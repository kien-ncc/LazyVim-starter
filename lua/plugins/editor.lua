return {
  {
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        -- vim.keymap.set("n", "<leader>ex", require("substitute").operator, { noremap = true, desc = "Substitute" }),
        vim.keymap.set("n", "gr", require("substitute").operator, { noremap = true, desc = "Substitute" }),
        --vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
        --vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
        vim.keymap.set("x", "gr", require("substitute").visual, { noremap = true, desc = "Substitute" }),
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<C-Tab>",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
      },
    },
  },
  {
    "folke/flash.nvim",
    -- stylua: ignore
    keys = {
      {
        "s", mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            search = {
              mode = function(str)
                return "\\<" .. str
              end,
            },
          })
        end, desc = "Flash beginning of words only" },
      { "S", mode = { "x", "o" }, false },
    },
  },
  -- nvim already has g text object?!
  -- { "kana/vim-textobj-entire" },
  -- Performance
  {
    "LunarVim/bigfile.nvim",
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
}
