--- 使用 gopls 整理 Go 文件 import（替代 goimports CLI，gopls 常驻且有索引缓存，速度更快）
---@param bufnr integer
local function go_organize_imports(bufnr)
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = "gopls" })[1]
  if not client then return end
  local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
  params.context = { only = { "source.organizeImports" }, diagnostics = {} }
  local res = client:request_sync("textDocument/codeAction", params, 3000, bufnr)
  for _, action in ipairs(res and res.result or {}) do
    if action.edit then vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding) end
  end
end

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts = require("astrocore").extend_tbl(opts, {
        format_on_save = function(bufnr)
          -- markdown 保留手写特殊格式，保存时不自动格式化
          local ft = vim.bo[bufnr].filetype
          if ft:match "^markdown" then return nil end
          -- gopls 在编辑后需先重新分析（大仓库 + staticcheck），500ms 偶发不够，Go 单独放宽
          return { timeout_ms = ft == "go" and 3000 or 500, lsp_format = "fallback" }
        end,
      })
      -- Go 不使用 goimports CLI（大仓库下单次 2~3s 导致保存超时），改由 gopls 格式化（已开启 gofumpt）
      -- 需整体替换：深度合并会保留 astrocommunity.pack.go 中列表里的 "goimports"
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.go = { lsp_format = "prefer" }
      return opts
    end,
  },
  {
    -- mason-null-ls 默认 handlers 会把 Mason 安装的 goimports 自动注册为 none-ls 格式化源，
    -- 导致保存时出现 "[LSP][null-ls] timeout"，此处禁用该自动注册
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.handlers = opts.handlers or {}
      opts.handlers.goimports = function() end
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        go_organize_imports = {
          {
            event = "BufWritePre",
            pattern = "*.go",
            desc = "保存前使用 gopls 整理 import",
            callback = function(args) go_organize_imports(args.buf) end,
          },
        },
      },
    },
  },
}
