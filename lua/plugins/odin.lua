local function has_odin() return vim.fn.executable "odin" == 1 end

return {
  "cephei8/odin.nvim",
  lazy = false,
  opts = {},
  -- {
  --   "AstroNvim/astrolsp",
  --   opts = {
  --     config = {
  --       ols = {
  --         filetypes = { "odin" },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "AstroNvim/astrocore",
  --   optional = true,
  --   opts = {
  --     -- treesitter = { ensure_installed = { "odin" } },
  --     treesitter = has_odin() and { ensure_installed = { "odin" } } or nil,
  --   },
  -- },
  -- {
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     if has_odin() then
  --       opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "ols" })
  --     end
  --   end,
  -- },
  -- {
  --   "mason-org/mason-lspconfig.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     if has_odin() then
  --       opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "ols" })
  --     end
  --   end,
  -- },
}
