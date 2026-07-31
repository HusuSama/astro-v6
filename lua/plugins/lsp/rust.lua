return {
  "mrcjkb/rustaceanvim",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            files = {
              exclude = {
                ".direnv",
                ".git",
                ".jj",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
              -- Avoid Roots Scanned hanging, see https://github.com/rust-lang/rust-analyzer/issues/12613#issuecomment-2096386344
              watcher = "client",
            },
          },
        },
      },
    })
  end,
}
