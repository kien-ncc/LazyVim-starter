return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
    },
  },
  {
    "echasnovski/mini.surround",
    -- init = function() end,
    -- keys = function(_, keys)
    --   -- vim.keymap.del("x", "ys")
    --   vim.keymap.set("x", "S", [[:<C-u>lua require('mini.surround').add('visual')<CR>]], { silent = true })
    --   return keys
    -- end,
    -- opts = function(_, opts)
    --   -- vim.list_extend(opts, {
    --   --   mappings = {
    --   --     add = "ys",
    --   --     delete = "ds",
    --   --     replace = "cs",
    --   --   },
    --   -- })
    --   opts.mappings =
    --     {
    --       add = "ys",
    --       delete = "ds",
    --       replace = "cs",
    --     },
    --     -- Remap adding surrounding to Visual mode selection
    --     -- vim.keymap.del("o", "S")
    --     -- vim.keymap.del("x", "ys")
    --     vim.keymap.set("x", "S", [[:<C-u>lua require('mini.surround').add('visual')<CR>]], { silent = true })
    -- end,
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
      { "S", mode = { "x", "o" }, false },
    },
  },
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
