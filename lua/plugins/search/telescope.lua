return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    local action = require "telescope.actions"
    return require("astrocore").extend_tbl(opts, {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = action.move_selection_next,
            ["<C-k>"] = action.move_selection_previous,
            ["<C-p>"] = action.move_selection_previous,
            ["<C-n>"] = action.move_selection_next,
          },
        },
      },
    })
  end,
}
