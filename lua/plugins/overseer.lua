return {
  {
    "stevearc/overseer.nvim",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        strategy = {
          open_on_start = false,
          hidden = true,
        },
      })
    end,
  },
}
