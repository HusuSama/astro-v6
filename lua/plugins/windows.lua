return {
  "anuvyklack/windows.nvim",
  opts = function(_, opts)
    require("astrocore").extend_tbl(opts, {
      autowidth = {
        enable = true,
      },
    })
  end,
}
