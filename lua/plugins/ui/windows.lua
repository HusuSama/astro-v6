return {
  "anuvyklack/windows.nvim",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      autowidth = {
        enable = true,
      },
    })
  end,
}
