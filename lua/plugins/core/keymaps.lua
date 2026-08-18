return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        ["<C-s>"] = { "<Cmd>write<CR>", desc = "保存" },
        ["<C-a>"] = { "ggVG", desc = "全选" },
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        ["<A-l>"] = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        ["<A-h>"] = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        ["<Leader>fT"] = { "<Cmd>TodoTelescope<CR>", desc = "搜索TODO" },
        ["<Leader>Tl"] = { "<Cmd>TodoLocList<CR>", desc = "TODO列表" },
        ["<Leader>Tq"] = { "<Cmd>TodoQuickFix<CR>", desc = "TODO快速修复" },
        ["]t"] = { function() require("todo-comments").jump_next() end, desc = "跳到下一个TODO" },
        ["[t"] = { function() require("todo-comments").jump_prev() end, desc = "跳到上一个TODO" },
        ["<C-\\>"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle terminal" },
        ["<F7>"] = { "<Cmd>ToggleTerm size=25 direction=horizontal<CR>", desc = "ToggleTerm Harizontal" },
        ["<F12>"] = {
          function() vim.notify("aerial.nvim is disabled", vim.log.levels.WARN) end,
          desc = "Find aerial",
        },
        ["<C-F12>"] = {
          function() vim.notify("aerial.nvim is disabled", vim.log.levels.WARN) end,
          desc = "Symbols outline",
        },
        ["<Leader>ZM"] = { "<Cmd>ZenMode<CR>", desc = "Zen Mode" },
        ["<F10>"] = { "<Cmd>OverseerToggle right<CR>", desc = "Overseer Toggle" },
        d = { '"_d', desc = "删除而不剪切" },
        x = { '"_x', desc = "删除单个字符不剪切" },
        dd = { '"_dd', desc = "删除一行不剪切" },
        D = { '"_D', desc = "删除不剪切" },
        X = { '"_X', desc = "删除不剪切" },
        ["<Leader>MW"] = {
          function()
            if vim.bo.filetype ~= "markdown" then return end
            local task = require("overseer.task").new {
              cmd = "markmap -w " .. vim.fn.expand "%",
              name = "MarkmapRunner",
              components = { { "on_complete_notify", statuses = { "success" } } },
            }
            task:start()
          end,
          desc = "markmap watch",
        },
        ["<Leader>fj"] = { "<Cmd>Telescope jumplist<CR>", desc = "find jumplist" },
      },
      t = {
        ["<Esc><Esc>"] = { "<C-\\><C-n>", desc = "normal mode" },
      },
      i = {
        ["<C-h>"] = { "<Left>" },
        ["<C-l>"] = { "<Right>" },
        ["<C-v>"] = { "<C-r>+" },
        ["<D-v>"] = { "<C-r>+" },
        ["<C-z>"] = { "<Cmd>undo<CR>" },
        ["<C-s>"] = { "<Cmd>write<CR>", desc = "write" },
        ["<C-k>"] = { "<Cmd>normal zz<CR>", desc = "norm zz" },
      },
      v = {
        ["<C-c>"] = { "y" },
        ["<D-c>"] = { "y" },
        d = { '"_d', desc = "删除而不剪切" },
      },
      c = {
        ["<C-h>"] = { "<Left>" },
        ["<C-l>"] = { "<Right>" },
        ["<C-v>"] = { "<C-r>+" },
      },
    },
  },
}
