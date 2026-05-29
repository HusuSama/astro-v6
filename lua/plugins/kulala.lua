return {
  "mistweaverco/kulala.nvim",
  ft = { "*" },
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      ui = {
        display_mode = "float",
      },
    })
  end,
}
