-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },

  -- { import = "astrocommunity/recipes/heirline-nvchad-statusline" },
  -- { import = "astrocommunity/recipes/cache-colorscheme" },

  -- themes
  { import = "astrocommunity.colorscheme.everforest" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.nordic-nvim" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  -- { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.kanagawa-paper-nvim" },
  { import = "astrocommunity.colorscheme.night-owl-nvim" },
  { import = "astrocommunity.colorscheme.palenight-nvim" },
  { import = "astrocommunity.colorscheme.rose-pine" },

  -- git
  { import = "astrocommunity.git.blame-nvim" },

  -- lsp
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.java" },
  -- { import = "astrocommunity.lsp.nvim-java" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.python.base" },
  { import = "astrocommunity.pack.python.ty" },
  { import = "astrocommunity.pack.python.ruff" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.go" },
  -- { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.thrift" },
  { import = "astrocommunity.pack.prettier" },
  { import = "astrocommunity.pack.golangci-lint" },
  -- { import = "astrocommunity.pack.harper" },
  -- { import = "astrocommunity.lsp.ts-error-translator-nvim" },
  -- { import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },
  -- { import = "astrocommunity.lsp.lspsaga-nvim" },
  -- { import = "astrocommunity.lsp.garbage-day-nvim" },

  -- test
  -- { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.test.vim-test" },

  -- debug
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  { import = "astrocommunity.debugging.telescope-dap-nvim" },

  -- editor helper
  -- { import = "astrocommunity.completion.nvim-cmp" },
  { import = "astrocommunity.completion.blink-cmp" },
  -- { import = "astrocommunity.completion.blink-cmp-git" },
  { import = "astrocommunity.completion.blink-cmp-emoji" },
  -- { import = "astrocommunity.completion.cmp-emoji" },
  -- { import = "astrocommunity.ai.avante-nvim" },
  -- { import = "astrocommunity.ai.sidekick-nvim" },
  -- { import = "astrocommunity.ai.codecompanion-nvim" },
  { import = "astrocommunity.diagnostics.tiny-inline-diagnostic-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.editing-support.neogen" },
  { import = "astrocommunity.editing-support.comment-box-nvim" },
  { import = "astrocommunity.editing-support.yanky-nvim" },
  -- { import = "astrocommunity.editing-support.rustowl" },
  { import = "astrocommunity.editing-support.vim-move" },
  -- { import = "astrocommunity.editing-support.undotree" },
  -- { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  -- { import = "astrocommunity.editing-support.vim-visual-multi" },
  { import = "astrocommunity.comment.ts-comments-nvim" },
  -- { import = "astrocommunity.editing-support.ultimate-autopair-nvim" },
  { import = "astrocommunity.search.grug-far-nvim" },
  { import = "astrocommunity.programming-language-support.kulala-nvim" },
  -- { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  -- { import = "astrocommunity.workflow.precognition-nvim" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  -- { import = "astrocommunity.workflow.hardtime-nvim" },
  { import = "astrocommunity.split-and-window.windows-nvim" },
  -- { import = "astrocommunity.file-explorer.oil-nvim" },
  -- motion
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.marks-nvim" },
  { import = "astrocommunity.motion.mini-surround" },
  -- { import = "astrocommunity.motion.nvim-surround" },
  -- { import = "astrocommunity.motion.vim-matchup" },
  -- { import = "astrocommunity.motion.harpoon" },

  -- runner
  { import = "astrocommunity.code-runner.overseer-nvim" },

  -- others
  -- { import = "astrocommunity.utility.telescope-live-grep-args-nvim" },
  -- { import = "astrocommunity.color.nvim-highlight-colors" },
  -- { import = "astrocommunity.remote-development.distant-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },

  { import = "astrocommunity.utility.noice-nvim" },

  { import = "astrocommunity.terminal-integration.toggleterm-manager-nvim" },
  -- { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { import = "astrocommunity.ai.opencode-nvim" },
  -- { import = "astrocommunity.media.img-clip-nvim" },
}
