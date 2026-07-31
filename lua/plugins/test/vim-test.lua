return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    opts.options.g["test#go#gotest#options"] = "-v -count=1"
    opts.options.g["test#rust#cargotest#options"] = "-- --nocapture --include-ignored"
    opts.options.g["test#neovim#start_normal"] = 1
    opts.options.g["test#basic#start_normal"] = 1
    -- opts.options.g["test#strategy"] = "toggleterm"
  end,
}
