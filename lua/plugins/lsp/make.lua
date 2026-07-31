-- 使用 make-ls 需要手动安装：go install github.com/owenrumney/make-ls/cmd/make-ls@latest
-- Makfile用于make命令构建，在 Windows 中需要额外安装，linux 和 macOS 可以直接使用
-- 在 Windows 中如果需要使用，可以再安装 make 之类的工具，但如果只是构建简单命令， Windows 可以使用 mise 等其他工具
local function has_makels() return vim.fn.executable "make-ls" == 1 end

return {
  "AstroNvim/astrocore",
  opts = {
    autocmds = {
      make_ls = {
        {
          event = "FileType",
          pattern = "make",
          callback = function()
            if not has_makels() then return end

            vim.lsp.start {
              name = "make-ls",
              cmd = { "make-ls" },
              root_dir = vim.fs.root(0, { "Makefile", "makefile", "GNUmakefile" }),
            }
          end,
        },
      },
    },
  },
}
