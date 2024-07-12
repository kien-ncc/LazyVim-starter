local renderer = require("neo-tree.ui.renderer")
-- The nodes inside the root folder are depth 2.
local MIN_DEPTH = 2
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

-- Expand a node and load filesystem info if needed.
local open_dir = function(state, dir_node)
  local fs = require("neo-tree.sources.filesystem")
  fs.toggle_directory(state, dir_node, nil, true, false)
end
-- Expand a node and all its children, optionally stopping at max_depth.
local recursive_open = function(state, node, max_depth)
  local max_depth_reached = 1
  local stack = { node }
  while next(stack) ~= nil do
    node = table.remove(stack)
    if node.type == "directory" and not node:is_expanded() then
      open_dir(state, node)
    end

    local depth = node:get_depth()
    max_depth_reached = math.max(depth, max_depth_reached)

    if not max_depth or depth < max_depth - 1 then
      local children = state.tree:get_nodes(node:get_id())
      for _, v in ipairs(children) do
        table.insert(stack, v)
      end
    end
  end

  return max_depth_reached
end
local neotree_zo = function(state, open_all)
  local node = state.tree:get_node()

  if open_all then
    recursive_open(state, node)
  else
    recursive_open(state, node, node:get_depth() + vim.v.count1)
  end

  renderer.redraw(state)
end
local recursive_close = function(state, node, max_depth)
  if max_depth == nil or max_depth <= MIN_DEPTH then
    max_depth = MIN_DEPTH
  end

  local last = node
  while node and node:get_depth() >= max_depth do
    if node:has_children() and node:is_expanded() then
      node:collapse()
    end
    last = node
    node = state.tree:get_node(node:get_parent_id())
  end

  return last
end
local neotree_zc = function(state, close_all)
  local node = state.tree:get_node()
  if not node then
    return
  end

  local max_depth
  if not close_all then
    max_depth = node:get_depth() - vim.v.count1
    if node:has_children() and node:is_expanded() then
      max_depth = max_depth + 1
    end
  end

  local last = recursive_close(state, node, max_depth)
  renderer.redraw(state)
  renderer.focus_node(state, last:get_id())
end
local neotree_za = function(state, toggle_all)
  local node = state.tree:get_node()
  if not node then
    return
  end

  if node.type == "directory" and not node:is_expanded() then
    neotree_zo(state, toggle_all)
  else
    neotree_zc(state, toggle_all)
  end
end

--- Set depthlevel, analagous to foldlevel, for the neo-tree file tree.
local set_depthlevel = function(state, depthlevel)
  if depthlevel < MIN_DEPTH then
    depthlevel = MIN_DEPTH
  end

  local stack = state.tree:get_nodes()
  while next(stack) ~= nil do
    local node = table.remove(stack)

    if node.type == "directory" then
      local should_be_open = depthlevel == nil or node:get_depth() < depthlevel
      if should_be_open and not node:is_expanded() then
        open_dir(state, node)
      elseif not should_be_open and node:is_expanded() then
        node:collapse()
      end
    end

    local children = state.tree:get_nodes(node:get_id())
    for _, v in ipairs(children) do
      table.insert(stack, v)
    end
  end

  vim.b.neotree_depthlevel = depthlevel
end

--- Refresh the tree UI after a change of depthlevel.
-- @bool stay Keep the current node revealed and selected
local redraw_after_depthlevel_change = function(state, stay)
  local node = state.tree:get_node()

  if stay then
    require("neo-tree.ui.renderer").expand_to_node(state.tree, node)
  else
    -- Find the closest parent that is still visible.
    local parent = state.tree:get_node(node:get_parent_id())
    while not parent:is_expanded() and parent:get_depth() > 1 do
      node = parent
      parent = state.tree:get_node(node:get_parent_id())
    end
  end

  renderer.redraw(state)
  renderer.focus_node(state, node:get_id())
end

local commands = {
  -- thanks https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1165#issuecomment-1740137096
  next_sibling = function(state)
    local node = state.tree:get_node()
    local siblings = getSiblings(state, node)
    if not node.is_last_child then
      local currentIndex = indexOf(siblings, node.id)
      local nextIndex = siblings[currentIndex + 1]
      renderer.focus_node(state, nextIndex)
    end
  end,
  prevSibling = function(state)
    local node = state.tree:get_node()
    local siblings = getSiblings(state, node)
    local currentIndex = indexOf(siblings, node.id)
    if currentIndex > 1 then
      local nextIndex = siblings[currentIndex - 1]
      renderer.focus_node(state, nextIndex)
    end
  end,
  firstSibling = function(state)
    local node = state.tree:get_node()
    local siblings = getSiblings(state, node)
    renderer.focus_node(state, siblings[1])
  end,
  lastSibling = function(state)
    local node = state.tree:get_node()
    local siblings = getSiblings(state, node)
    renderer.focus_node(state, siblings[#siblings])
  end,
  --thanks: https://github.com/ghostbuster91/dot-files/blob/ce02eedc563d0bf9165ee5312caa968e837aea2c/modules/hm/neovim/lua/local/neotree/init.lua#L18
  --- Recursively open the current folder and all folders it contains.
  expand_all_default = function(state)
    local node = state.tree:get_node()
    ---@diagnostic disable-next-line: missing-parameter
    require("neo-tree.sources.common.commands").expand_all_nodes(state, node)
  end,

  collapse_all_under_cursor = function(state)
    local active_node = state.tree:get_node()
    local stack = { active_node }

    while next(stack) ~= nil do
      local node = table.remove(stack)
      local children = state.tree:get_nodes(node:get_id())
      for _, v in ipairs(children) do
        table.insert(stack, v)
      end

      if node.type == "directory" and node:is_expanded() then
        node:collapse()
      end
    end

    renderer.redraw(state)
    renderer.focus_node(state, active_node:get_id())
  end,

  -- thanks https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#emulating-vims-fold-commands
  --- Open the fold under the cursor, recursing if count is given.
  neotree_zo = neotree_zo,

  --- Recursively open the current folder and all folders it contains.
  neotree_zO = function(state)
    neotree_zo(state, true)
  end,

  --- Close the node and its parents, optionally stopping at max_depth.
  recursive_close = recursive_close,

  --- Close a folder, or a number of folders equal to count.
  neotree_zc = neotree_zc,

  -- Close all containing folders back to the top level.
  neotree_zC = function(state)
    neotree_zc(state, true)
  end,

  --- Open a closed folder or close an open one, with an optional count.
  neotree_za = neotree_za,

  --- Recursively close an open folder or recursively open a closed folder.
  neotree_zA = function(state)
    neotree_za(state, true)
  end,

  --- Update all open/closed folders by depthlevel, then reveal current node.
  neotree_zx = function(state)
    set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
    redraw_after_depthlevel_change(state, true)
  end,

  --- Update all open/closed folders by depthlevel.
  neotree_zX = function(state)
    set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
    redraw_after_depthlevel_change(state, false)
  end,

  -- Collapse more folders: decrease depthlevel by 1 or count.
  neotree_zm = function(state)
    local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
    set_depthlevel(state, depthlevel - vim.v.count1)
    redraw_after_depthlevel_change(state, false)
  end,

  -- Collapse all folders. Set depthlevel to MIN_DEPTH.
  neotree_zM = function(state)
    set_depthlevel(state, MIN_DEPTH)
    redraw_after_depthlevel_change(state, false)
  end,

  -- Expand more folders: increase depthlevel by 1 or count.
  neotree_zr = function(state)
    local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
    set_depthlevel(state, depthlevel + vim.v.count1)
    redraw_after_depthlevel_change(state, false)
  end,

  -- Expand all folders. Set depthlevel to the deepest node level.
  neotree_zR = function(state)
    local top_level_nodes = state.tree:get_nodes()

    local max_depth = 1
    for _, node in ipairs(top_level_nodes) do
      max_depth = math.max(max_depth, recursive_open(state, node))
    end

    vim.b.neotree_depthlevel = max_depth
    redraw_after_depthlevel_change(state, false)
  end,
}

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", false },
      -- { "<leader>E", false },
      { "<M-1>", "<cmd>Neotree toggle<CR>", desc = "Toggle Neotree", mode = { "n" }, noremap = true },
      vim.keymap.set("n", "<M-1>", "<cmd>Neotree<CR>", { noremap = true, desc = "File outline" }),
    },
    -- opts = function(_, opts)
    opts = {
      commands = {
        close_after_open = function(state)
          local node = state.tree:get_node()
          if require("neo-tree.utils").is_expandable(node) then
            state.commands["toggle_node"](state)
          else
            state.commands["open"](state)
            require("neo-tree.command").execute({ action = "close" })
          end
        end,
      },
      window = {
        -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#open-file-without-losing-sidebar-focus
        -- local nerdmappings =
        mappings = {
          ["<Esc>"] = function(state)
            vim.cmd("wincmd l")
          end,
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
          -- ["O"] = "expand_all_nodes", Not working: https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/770#discussioncomment-6024344
          ["Z"] = "noop",
          ["z"] = "none",
          ["zO"] = commands.expand_all_default,
          ["zm"] = commands.collapse_all_under_cursor,
          -- ["zo"] = commands.neotree_zo,
          ["zO"] = commands.neotree_zO,
          ["zc"] = commands.neotree_zc,
          ["zC"] = commands.neotree_zC,
          ["za"] = commands.neotree_za,
          ["zA"] = commands.neotree_zA,
          ["zx"] = commands.neotree_zx,
          ["zX"] = commands.neotree_zX,
          ["zm"] = commands.neotree_zm,
          ["zM"] = commands.neotree_zM,
          ["zr"] = commands.neotree_zr,
          ["zR"] = commands.neotree_zR,
          ["<C-j>"] = { commands.next_sibling, desc = "next_sibling" },
          ["<C-k>"] = { commands.prevSibling, desc = "prev_sibling" },
          ["J"] = { commands.lastSibling, desc = "last_sibling" },
          ["K"] = { commands.firstSibling, desc = "first_sibling" },
          ["x"] = "close_all_subnodes",
          ["<C-x>"] = "cut_to_clipboard",
          ["<C-v>"] = "paste_from_clipboard",
          ["<S-CR>"] = "close_after_open",
          ["<cr>"] = "close_after_open",
          ["<C-o>"] = "open",
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
