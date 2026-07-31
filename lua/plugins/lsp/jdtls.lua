return {
  "mfussenegger/nvim-jdtls",
  opts = function(_, opts)
    local java = "/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home/bin/java"
    if vim.fn.executable(java) == 1 and opts.cmd then opts.cmd[1] = java end
  end,
}
