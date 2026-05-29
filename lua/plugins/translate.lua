return {
  -- "uga-rosa/translate.nvim",
  -- cmd = {
  --   "Translate",
  -- },
  -- keys = {
  --   { "<leader>tw", mode = { "n", "x" }, "<cmd>Translate ZH<cr>", desc = "translate ZH" },
  -- },
  -- opts = {},
  {
    "JuanZoran/Trans.nvim",
    build = function() require("Trans").install() end,
    keys = {
      -- 可以换成其他你想映射的键
      { "<leader>tw", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = "󰊿 Translate" },
    },
    dependencies = { "kkharji/sqlite.lua" },
    opts = {
      theme = "tokyonight",
      frontend = {
        default = {
          animation = {
            open = "fold",
            close = "fold",
            interval = 8,
          },
        },
      },
    },
  },
}
