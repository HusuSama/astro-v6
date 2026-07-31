-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
-- return {
--   "nvim-treesitter/nvim-treesitter",
--   opts = {
--     ensure_installed = {
--       "lua",
--       "vim",
--       -- add more arguments for adding more treesitter parsers
--     },
--   },
-- }
return {
  {

    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.treesitter.ensure_installed = require("astrocore").list_insert_unique(opts.treesitter.ensure_installed, {
        "lua",
        "python",
        "go",
        "rust",
        "markdown",
        "yaml",
        "toml",
        "java",
      })
      opts.treesitter.textobjects = require("astrocore").extend_tbl(opts.treesitter.textobjects, {
        move = {
          goto_next_start = {
            ["<A-j>"] = { query = "@function.outer", desc = "Next function start" },
          },
          goto_previous_start = {
            ["<A-k>"] = { query = "@function.outer", desc = "Previous function start" },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
  },
}
