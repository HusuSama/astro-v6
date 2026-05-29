return {
  "stevearc/aerial.nvim",
  enabled = false,
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      disable_max_lines = 10000,
      disable_max_size = 2000000,
      layout = {
        max_width = { 80, 0.4 },
        min_width = 80,
      },
      close_on_select = true,
    })
  end,
}
