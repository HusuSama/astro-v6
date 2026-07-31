-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      -- change colorscheme
      -- colorscheme = "astrodark",
      -- colorscheme = "everforest",
      -- colorscheme = "catppuccin-frappe",
      -- colorscheme = "catppuccin-mocha",
      colorscheme = "catppuccin-macchiato",
      -- colorscheme = "tokyonight",
      -- colorscheme = "nordic",
      -- colorscheme = "kanagawa-lotus",
      -- colorscheme = "kanagawa-paper-ink",
      -- colorscheme = "onedark_vivid",
      -- colorscheme = "night-owl",
      -- colorscheme = "palenight",
      -- colorscheme = "rose-pine-moon",
      -- colorscheme = "onedark",
      -- colorscheme = "onelight",
      -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
      highlights = {
        init = { -- this table overrides highlights in all themes
          -- Normal = { bg = "#000000" },
        },
        astrodark = { -- a table of overrides/changes when applying the astrotheme theme
          -- Normal = { bg = "#000000" },
        },
      },
      -- Icons can be configured throughout the interface
      icons = {
        -- configure the loading of the lsp in the status line
        LSPLoading1 = "⠋",
        LSPLoading2 = "⠙",
        LSPLoading3 = "⠹",
        LSPLoading4 = "⠸",
        LSPLoading5 = "⠼",
        LSPLoading6 = "⠴",
        LSPLoading7 = "⠦",
        LSPLoading8 = "⠧",
        LSPLoading9 = "⠇",
        LSPLoading10 = "⠏",
      },
    },
  },
  {
    "catppuccin/nvim",
    opts = function(_, opts)
      local colors = require("catppuccin.palettes").get_palette "frappe"
      return require("astrocore").extend_tbl(opts, {
        -- no_italic = true,
        -- no_bold = true,
        -- styles = {
        --   conditionals = { "bold" },
        --   keywords = { "bold" },
        --   loop = { "bold" },
        --   -- italic = { "italic " },
        -- },
        -- custom_highlights = {
        --   ["@module"] = { fg = colors.teal },
        --   ["@parameter"] = { fg = colors.text },
        --   ["@type.builtin"] = { fg = colors.yellow },
        --   Type = { fg = colors.yellow },
        --   ["@function.builtin"] = { fg = colors.peach },
        -- },
      })
    end,
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = function(_, opts)
  --     return require("astrocore").extend_tbl(opts, {
  --       style = { "storm" },
  --       styles = {
  --         keywords = { "bold" },
  --       },
  --     })
  --   end,
  -- },
}
