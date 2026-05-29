local Snacks = require "snacks"

return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        enabled = true,
        chunk = {
          enabled = true,
          char = {
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          },
        },
        animate = {
          enabled = true,
        },
      },
    },
    keys = {
      { "g/", function() Snacks.picker.grep() end, desc = "Snacks Grep" },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      if opts.mappings.n["<Leader>lR"] then
        opts.mappings.n["<Leader>lR"][1] = function()
          require("snacks.picker").lsp_references {
            auto_confirm = false,
            auto_close = true,
            layout = { preset = "telescope" },
          }
        end
      end
      if opts.mappings.n.gd then
        opts.mappings.n.gd[1] = function()
          require("snacks.picker").lsp_definitions {
            auto_close = true,
            auto_confirm = true,
            layout = { preset = "telescope" },
          }
        end
      end
      if opts.mappings.n.gI then
        opts.mappings.n.gI[1] = function()
          require("snacks.picker").lsp_implementations {
            auto_close = true,
            auto_confirm = true,
            layout = { preset = "telescope" },
          }
        end
      end
      if opts.mappings.n.gy then
        opts.mappings.n.gy[1] = function()
          require("snacks.picker").lsp_type_definitions {
            auto_close = true,
            auto_confirm = true,
            layout = { preset = "telescope" },
          }
        end
      end
      if opts.mappings.n["<leader>lG"] then
        opts.mappings.n.gd[1] = function()
          require("snacks.picker").lsp_workspace_symbols {
            auto_close = true,
            auto_confirm = true,
            layout = { preset = "telescope" },
          }
        end
      end
    end,
  },
}
