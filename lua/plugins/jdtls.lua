return {
  "mfussenegger/nvim-jdtls",
  -- opts = function(_, opts) opts.root_dir = vim.fs.root(0, { "src" }) end,
  opts = function(_, opts) opts.cmd[1] = "/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home/bin/java" end,
}
