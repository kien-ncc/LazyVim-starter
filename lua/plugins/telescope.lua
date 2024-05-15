return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        path_display = { "truncate" }, -- "shorten"
        __generic_sorter = function(opts, list)
          local conf = require("telescope.config").values
          local indices = {}
          for i, line in ipairs(list) do
            indices[line] = i
          end
          local file_sorter = conf.file_sorter(opts)
          local base_scorer = file_sorter.scoring_function
          file_sorter.scoring_function = function(self, prompt, line)
            local score = base_scorer(self, prompt, line)
            if score <= 0 then
              return -1
            else
              return indices[line]
            end
          end
          return file_sorter
        end,
      },
    },
  },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
      -- optional, if using telescope for vim.ui.select
      -- "stevearc/dressing.nvim"
    },
    opts = {
      database = {
        folder = vim.fn.stdpath("data"),
        file = "telescope-all-recent.sqlite3",
        max_timestamps = 10,
      },
      debug = false,
      scoring = {
        recency_modifier = { -- also see telescope-frecency for these settings
          [1] = { age = 240, value = 100 }, -- past 4 hours
          [2] = { age = 1440, value = 80 }, -- past day
          [3] = { age = 4320, value = 60 }, -- past 3 days
          [4] = { age = 10080, value = 40 }, -- past week
          [5] = { age = 43200, value = 20 }, -- past month
          [6] = { age = 129600, value = 10 }, -- past 90 days
        },
        -- how much the score of a recent item will be improved.
        boost_factor = 0.0001,
      },
      default = {
        disable = true, -- disable any unkown pickers (recommended)
        use_cwd = true, -- differentiate scoring for each picker based on cwd
        sorting = "recent", -- sorting: options: 'recent' and 'frecency'
      },
      pickers = { -- allows you to overwrite the default settings for each picker
        man_pages = { -- enable man_pages picker. Disable cwd and use frecency sorting.
          disable = false,
          use_cwd = false,
          sorting = "frecency",
        },

        -- change settings for a telescope extension.
        -- To find out about extensions, you can use `print(vim.inspect(require'telescope'.extensions))`
        -- ["extension_name#extension_method"] = {
        -- [...]
        -- },
      },
    },
  },
}
