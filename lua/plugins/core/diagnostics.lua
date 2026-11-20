return {
  {
    "AstroNvim/astrocore",
    opts = {
      diagnostics = {
        -- 临时绕过 Neovim 0.12.2 在打开文件时因诊断行号越界导致的下划线渲染异常。
        -- 确认升级后的版本已修复此问题后，可删除此设置以恢复下划线。
        underline = false,
      },
    },
  },
}
