-- /home/stevearc/.config/nvim/lua/overseer/template/user/cpp_build.lua
local problem_matcher_gradle = require("overseer.problem_matcher_gradle")
return {
  name = "gradle :app-android:assembleDebug",
  builder = function()
    -- Full path to current file (see :help expand())
    -- local file = vim.fn.expand("%:p")
    return {
      cmd = { "./gradlew" },
      args = { --"--console=plain",
        ":app-android:packageDebug",
      },
      components = {
        -- { "on_output_quickfix", open = true },
        {
          "on_output_parse",
          problem_matcher = problem_matcher_gradle,
        },
        "on_result_diagnostics_quickfix",
        "on_result_diagnostics",
        "default",
      },
    }
  end,
  condition = {
    filetype = { "kotlin", "gradle", "markdown" },
  },
}
