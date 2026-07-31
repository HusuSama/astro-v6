return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      format_on_save = {
        timeout = 500,
        lsp_format = "fallback",
      },
    })
  end,
}
