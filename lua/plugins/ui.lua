return {
  {
    "MunifTanjim/nui.nvim",
    config = function()
      local Popup = require("nui.popup")
      local popup = Popup({
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:SpecialChar",
        },
      })
    end,
  },
}
