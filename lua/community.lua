-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

local function has_command(command) return vim.fn.executable(command) == 1 end

-- 增加环境变量机制，可以临时启用，但是如果安装了，并不会撤销安装
local function enabled(name, detected)
  local override = vim.env["NVIM_ENABLE_" .. name]
  if override == "1" then return true end
  if override == "0" then return false end
  return detected
end

-- 局部变量，用于判断某些命令是否存在，针对性的导入插件

local has_go = enabled("GO", has_command "go")
local has_cpp = enabled("CPP", has_command "clang++" or has_command "g++" or has_command "cl")
local has_python = enabled("PYTHON", has_command "python3" or has_command "python")
local has_java = enabled("JAVA", has_command "java")
local has_rust = enabled("RUST", has_command "cargo" or has_command "rustup")
local has_opencode_agent = has_command "opencode"
local has_git = has_command "git"
local has_js_runtime = has_command "node" or has_command "bun"

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },

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
  { import = "astrocommunity.git.blame-nvim", enabled = has_git },

  -- lsp
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.java", enabled = has_java },
  -- { import = "astrocommunity.lsp.nvim-java" },
  { import = "astrocommunity.pack.vue", enabled = has_js_runtime },
  { import = "astrocommunity.pack.rust", enabled = has_rust },
  { import = "astrocommunity.pack.python.base", enabled = has_python },
  { import = "astrocommunity.pack.python.ty", enabled = has_python },
  { import = "astrocommunity.pack.python.ruff", enabled = has_python },
  { import = "astrocommunity.pack.html-css", enabled = has_js_runtime },
  { import = "astrocommunity.pack.tailwindcss", enabled = has_js_runtime },
  { import = "astrocommunity.pack.typescript", enabled = has_js_runtime },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.go", enabled = has_go },
  { import = "astrocommunity.pack.golangci-lint", enabled = has_go },
  -- { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.thrift" },
  { import = "astrocommunity.pack.prettier" },
  { import = "astrocommunity.pack.oxlint" },
  { import = "astrocommunity.pack.cpp", enabled = has_cpp },
  { import = "astrocommunity.pack.ps1", enabled = vim.fn.has "win32" == 1 },
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

  -- { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { import = "astrocommunity.ai.opencode-nvim", enabled = has_opencode_agent },
  -- { import = "astrocommunity.media.img-clip-nvim" },
  -- { import = "astrocommunity.note-taking.zk-nvim" },
  --
}
