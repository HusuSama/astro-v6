return {
  "mfussenegger/nvim-jdtls",
  opts = function(_, opts)
    local java = "/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home/bin/java"
    if vim.fn.executable(java) == 1 and opts.cmd then opts.cmd[1] = java end
    local configure_snippets = require("utils").configure_lsp_snippets "jdtls"
    opts.before_init = require("astrocore").patch_func(opts.before_init, function(orig, ...)
      orig(...)
      configure_snippets(...)
    end)
  end,
}
