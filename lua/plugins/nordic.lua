return {
  "AlexvZyl/nordic.nvim",
  opts = function(_, opts)
    require("astrocore").extend_tbl(opts, {
      bold_keywords = true,
    })
  end,
}
