return{
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
}
