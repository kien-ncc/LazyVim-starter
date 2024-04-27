-- thanks https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1165#issuecomment-1740137096
local renderer = require("neo-tree.ui.renderer")
local indexOf = function(array, value)
  for i, v in ipairs(array) do
    if v == value then
      return i
    end
  end
  return nil
end
local getSiblings = function(state, node)
  local parent = state.tree:get_node(node:get_parent_id())
  local siblings = parent:get_child_ids()
  return siblings
end
local next_sibling = function(state)
  local node = state.tree:get_node()
  local siblings = getSiblings(state, node)
  if not node.is_last_child then
    local currentIndex = indexOf(siblings, node.id)
    local nextIndex = siblings[currentIndex + 1]
    renderer.focus_node(state, nextIndex)
  end
end
local prevSibling = function(state)
  local node = state.tree:get_node()
  local siblings = getSiblings(state, node)
  local currentIndex = indexOf(siblings, node.id)
  if currentIndex > 1 then
    local nextIndex = siblings[currentIndex - 1]
    renderer.focus_node(state, nextIndex)
  end
end
local firstSibling = function(state)
  local node = state.tree:get_node()
  local siblings = getSiblings(state, node)
  renderer.focus_node(state, siblings[1])
end

local lastSibling = function(state)
  local node = state.tree:get_node()
  local siblings = getSiblings(state, node)
  renderer.focus_node(state, siblings[#siblings])
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
    },
    -- opts = function(_, opts)
    opts = {
      commands = {
        close_after_open = function(state)
          state.commands["open"](state)
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
      window = {
        -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#open-file-without-losing-sidebar-focus
        -- local nerdmappings =
        mappings = {
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
              renderer.focus_node(state, node:get_parent_id())
            end,
            desc = "Move to parent",
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
            desc = "out - Navigation with HJKL",
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
            desc = "in - Navigation with HJKL",
          },
          ["o"] = { "toggle_node", desc = "toggle_node" },
          ["<C-j>"] = { next_sibling, desc = "next_sibling" },
          ["<C-k>"] = { prevSibling, desc = "prev_sibling" },
          ["J"] = { lastSibling, desc = "last_sibling" },
          ["K"] = { firstSibling, desc = "first_sibling" },
          ["x"] = "close_all_subnodes",
          ["<C-x>"] = "cut_to_clipboard",
          ["<C-v>"] = "paste_from_clipboard",
          ["<S-CR>"] = "close_after_open",
          ["<C-o>"] = "close_after_open",
        },
      },
      document_symbols = {
        follow_cursor = true,
      },
      -- for k, v in pairs(nerdmappings) do
      --   -- table.insert(opts.window.mappings)
      --   opts.window.mappings[k] = v
      -- end
      -- end,
    },
  },
}