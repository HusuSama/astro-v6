local function set_relative_number(enabled)
  if vim.o.number then vim.opt.relativenumber = enabled end
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      terminal_mappings = {
        {
          event = "TermOpen",
          pattern = "term://*",
          callback = function(args)
            local opts = { buffer = args.buf }
            vim.keymap.set("t", "<C-S-q>", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
          end,
        },
      },
      relative_number_on = {
        {
          event = { "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" },
          callback = function()
            if vim.api.nvim_get_mode().mode ~= "i" then set_relative_number(true) end
          end,
        },
      },
      relative_number_off = {
        {
          event = { "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" },
          callback = function()
            set_relative_number(false)
            -- Work around https://github.com/neovim/neovim/issues/32068.
            if vim.o.number and not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then vim.cmd.redraw() end
          end,
        },
      },
    },
  },
}
