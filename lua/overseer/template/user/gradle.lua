-- /home/stevearc/.config/nvim/lua/overseer/template/user/cpp_build.lua
return {
  name = "gradle :app-android:assembleDebug",
  builder = function()
    -- Full path to current file (see :help expand())
    -- local file = vim.fn.expand("%:p")
    return {
      cmd = { "./gradlew" },
      args = { --"--console=plain",
        ":app-android:assembleDebug",
      },
      components = {
        -- { "on_output_quickfix", open = true },
        {
          "on_output_parse",
          problem_matcher = {
            owner = "kotlin",
            -- fileLocation = { "relative", "${cwd}" },
            pattern = {
              regexp = "^(\\w):\\s+(.*?):(\\d+):(\\d+)\\s+(.*)$",
              -- Optionally specify a vim-compatible regex for matching:
              -- e: file:///Users/admin/work/mmwave_app_notification/shared/src/commonMain/kotlin/com/finggallink/mmwave/notification/shared/welcome/WelcomeComponent.kt:7:16 Unresolved reference: Value
              vim_regexp = "\\v(\\w):\\s+file:\\/\\/(.{-}):(\\d+):(\\d+)\\s+(.*)$",
              -- Optionally specify a lua pattern for matching:
              -- lua_pat = "^([^%s].*)[\\(:](%d+)[,:](%d+)[^%a]*(%a+)%s+TS(%d+)%s*:%s*(.*)$",
              severity = 1,
              file = 2,
              line = 3,
              column = 4,
              message = 5,
              -- code = 6,
            },
          },
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
