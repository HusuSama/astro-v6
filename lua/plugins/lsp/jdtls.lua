return {
  "mfussenegger/nvim-jdtls",
  opts = function(_, opts)
    local configure_snippets = require("utils").configure_lsp_snippets "jdtls"
    opts.before_init = require("astrocore").patch_func(opts.before_init, function(orig, ...)
      orig(...)
      configure_snippets(...)
    end)
  end,
}
