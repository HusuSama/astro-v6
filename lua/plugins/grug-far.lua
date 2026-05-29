return {
  "MagicDuck/grug-far.nvim",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      prefills = {
        flags = "--pcre2",
      },
    })
  end,
}
