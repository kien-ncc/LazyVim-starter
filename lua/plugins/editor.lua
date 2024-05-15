return {
  {
    "gbprod/substitute.nvim",
    keys = {
      -- { "cx", mode = { "n" }, require("substitute.exchange").operator, desc = "Substitute.exchange" },
      {
        "<leader>ex",
        mode = { "n" },
        function()
          require("substitute.exchange").operator()
        end,
        desc = "Substitute.Exchange",
        -- remap = false,
      },
      {
        "<leader>er",
        mode = { "n" },
        function()
          require("substitute").operator()
        end,
        desc = "ReplaceWithReg@Substitute",
      },
      {
        "<leader>er",
        mode = { "x" },
        function()
          require("substitute").visual()
        end,
        desc = "ReplaceWithReg@Substitute",
      },
      {
        "X",
        mode = { "x" },
        function()
          require("substitute.exchange").visual()
        end,
        desc = "Substitute.Exchange",
      },
    },
    opts = function()
      local substitute = require("substitute")
      -- vim.keymap.set("n", "<leader>ex", require("substitute").operator, { noremap = true, desc = "Substitute" }),
      vim.keymap.set("n", "gr", substitute.operator, { noremap = true, desc = "Substitute" })
      --vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
      --vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
      vim.keymap.set("x", "gr", substitute.visual, { noremap = true, desc = "Substitute" })
      vim.keymap.set(
        "n",
        "cx",
        require("substitute.exchange").operator,
        { noremap = true, desc = "Substitute.Exchange" }
      )
      -- TODO Use keys ExOR opts only(exclusively).
      -- TODO Use either keys or opts.
      return {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
    -- config = function()
    --   require("substitute").setup({
    --     -- your configuration comes here
    --     -- or leave it empty to use the default settings
    --     -- refer to the configuration section below
    --   })
    -- end,
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
  {
    "chrisgrieser/nvim-spider",
    keys = {
      {
        mode = { "n", "o", "x" },
        -- "<S-Right>",
        "<M-f>",
        "<cmd>lua require('spider').motion('w')<CR>",
        desc = "[Spider]next subword start (w)",
      },
      {
        mode = { "n", "o", "x" },
        "<M-b>",
        "<cmd>lua require('spider').motion('b')<CR>",
        desc = "[Spider]previous subword start (b)",
      },
    },
  },
}
