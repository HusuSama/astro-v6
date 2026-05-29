return {
  "mg979/vim-visual-multi",
  event = { "User AstroFile", "InsertEnter" },
  dependencies = {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      if not opts.options then opts.options = {} end
      if not opts.options.g then opts.options.g = {} end
      opts.options.g.VM_silent_exit = 1
      opts.options.g.VM_show_warnings = 0
      opts.options.g.VM_default_mappings = 0
      if not opts.autocmds then opts.autocmds = {} end
      opts.autocmds.visual_multi_exit = {
        {
          event = "User",
          pattern = "visual_multi_exit",
          desc = "Avoid spurious 'hit-enter-prompt' when exiting vim-visual-multi",
          callback = function()
            vim.o.cmdheight = 1
            vim.schedule(function() vim.o.cmdheight = opts.options.opt.cmdheight end)
          end,
        },
      }
      if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
      local maps = assert(opts.mappings)
      maps.n["<C-LeftMouse>"] = { "<Plug>(VM-Mouse-Cursor)", desc = "Add cursor" }
      maps.n["<C-RightMouse>"] = { "<Plug>(VM-Mouse-Word)", desc = "Add cursor" }
      maps.n["<leader>ma"] = { "<Plug>(VM-Add-Cursor-At-Pos)", desc = "VM add cursor at pos" }
      maps.n["<A-Down>"] = { "<Plug>(VM-Add-Cursor-Down)", desc = "VM add cursor down" }
      maps.n["<A-Up>"] = { "<Plug>(VM-Add-Cursor-Up)", desc = "VM add cursor up" }
      maps.n["<A-n>"] = { "<Plug>(VM-Find-Under)", desc = "VM find under" }
      maps.n["<A-n>"] = { "<Plug>(VM-Find-Subword-Under)", desc = "VM find subword under" }
    end,
  },
}
