return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      -- opts.defaults["<leader>e"] = { name = "+editor" }
      -- opts.defaults["<leader>i"] = { name = "+ideals" }
    end,
  },
  { "wakatime/vim-wakatime" },
  {
    "gbprod/substitute.nvim",
    opts = function()
      --LazyVim.lsp.on_attach(function(client, buffer)
      --  vim.keymap.del("n", "gra")
      --  vim.keymap.del("n", "grn")
      --end)
      vim.keymap.del("x", "gra")
      local substitute = require("substitute")
      local exchange = require("substitute.exchange")
      -- vim.keymap.set("n", "<leader>ex", require("substitute").operator, { noremap = true, desc = "Substitute" }),
      vim.keymap.set("n", "gr", substitute.operator, { noremap = true, desc = "ReplaceWithReg@Substitute" })
      -- vim.keymap.set("n", "<leader>S", substitute.operator, { noremap = true, desc = "ReplaceWithReg@Substitute" })
      vim.keymap.set("x", "gr", substitute.visual, { noremap = true, desc = "ReplaceWithReg@Substitute" })
      vim.keymap.set("n", "grr", substitute.line, { noremap = true, desc = "ReplaceWithReg@Substitute Line" })
      -- vim.keymap.set("x", "<leader>S", substitute.visual, { noremap = true, desc = "ReplaceWithReg@Substitute" })
      vim.keymap.set("n", "cx", exchange.operator, { noremap = true, desc = "Substitute.Exchange" })
      vim.keymap.set("n", "cxx", exchange.line, { noremap = true, desc = "Substitute.Exchange line" })
      vim.keymap.set("x", "X", exchange.operator, { noremap = true, desc = "Substitute.Exchange" })
      return {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
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
        find = "gsf", --'sf' Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", --'sh' Highlight surrounding
        replace = "cs",
        update_n_lines = "gsn", --'sn' Update `n_lines`
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
                local upper = str:sub(1,1):upper()
                local rem=""
                if str:len() > 1 then rem=str:sub(2,-1) end
                return "\\<" .. str.."\\|"..upper..rem--..[[\ze\(\w\|\W\)]]--\\C
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
    enabled = true,
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "chrisgrieser/nvim-spider",
    keys = {
      {
        mode = { "i", "n", "o", "x" },
        -- "<S-Right>",
        "<M-w>",
        "<cmd>lua require('spider').motion('w')<CR>",
        desc = "[Spider]next subword start (w)",
      },
      {
        mode = { "i", "n", "o", "x" },
        "<M-b>",
        "<cmd>lua require('spider').motion('b')<CR>",
        desc = "[Spider]previous subword start (b)",
      },
      {
        mode = { "i", "n", "o", "x" },
        "<M-e>",
        "<cmd>lua require('spider').motion('e')<CR>",
        desc = "[Spider]previous subword end (e)",
      },
    },
  },
}
