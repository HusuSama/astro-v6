return {
  "nickjvandyke/opencode.nvim",
  config = function()
    ---@type opencode.Opts
    local opencode_cmd = "opencode --port"
    ---@type snacks.terminal.Opts
    local snacks_terminal_opts = {
      start_insert = true,
      win = {
        position = "right",
        enter = true,
        on_win = function(win)
          -- Set up keymaps and cleanup for an arbitrary terminal
          require("opencode.terminal").setup(win.win)
        end,
      },
    }
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function() require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts) end,
        stop = function() require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts):close() end,
        toggle = function() require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts) end,
      },
    }
  end,
}
