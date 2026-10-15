return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      format_on_save = function(bufnr)
        -- markdown 保留手写特殊格式，保存时不自动格式化
        if vim.bo[bufnr].filetype:match "^markdown" then return nil end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
    })
  end,
}
