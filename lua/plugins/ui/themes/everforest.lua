return {
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      opts.options.g.everforest_cursor = "green"
      opts.options.g.everforest_enable_italic = false
    end,
  },
}
