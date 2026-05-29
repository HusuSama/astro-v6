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

    "nvim-treesitter/nvim-treesitter",
    -- branch = "main",
    -- lazy = false,
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.branch = "main"
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        -- "lua"
        "lua",
        "python",
        "go",
        "rust",
        "markdown",
        "yaml",
        "toml",
        "java",
      })
      local object
      object = {
        move = {
          goto_next_start = {
            ["<A-j>"] = { query = "@function.outer", desc = "Next function start" },
          },
          goto_previous_start = {
            ["<A-k>"] = { query = "@function.outer", desc = "Previous function start" },
          },
        },
      }
      return require("astrocore").extend_tbl(opts, {
        highlight = {
          enable = true,
          disable = false,
          additional_vim_regex_highlighting = false,
        },
        textobjects = object,
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
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
