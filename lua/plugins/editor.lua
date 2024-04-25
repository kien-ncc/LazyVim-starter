return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
    },
    opts = function(_, opts)
      -- opts = {
      --   window = {
      --https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#open-file-without-losing-sidebar-focus
      local nerdmappings = {
        -- mappings =
        ["<tab>"] = {
          function(state)
            local node = state.tree:get_node()
            if require("neo-tree.utils").is_expandable(node) then
              state.commands["toggle_node"](state)
            else
              state.commands["open"](state)
              vim.cmd("Neotree reveal")
            end
          end,
          desc = "Open file without losing sidebar focus",
        },
        --Navigation with HJKL,
        ["p"] = {
          function(state)
            local node = state.tree:get_node()
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end,
          desc = "Navigation with HJKL",
        },
        ["h"] = {
          function(state)
            local node = state.tree:get_node()
            if node.type == "directory" and node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
          end,
          desc = "Navigation with HJKL",
        },
        ["l"] = {
          function(state)
            local node = state.tree:get_node()
            if node.type == "directory" then
              if not node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(state, node)
              elseif node:has_children() then
                require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
              end
            end
          end,
          desc = "Navigation with HJKL",
        },
        ["o"] = { "toggle_node", desc = "toggle_node" },
        -- ["<c-j>"] = "next_sibling",
        -- ["<c-k>"] = "prev_sibling",
      } --,
      -- },
      for k, v in pairs(nerdmappings) do
        -- table.insert(opts.window.mappings)
        opts.window.mappings[k] = v
      end
    end,
    -- },
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
