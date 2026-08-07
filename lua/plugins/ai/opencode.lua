return {
  {
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
        select = {
          prompts = {
            ask = "...",
            diagnostics = "Explain @diagnostics ",
            document = "Add comments documenting @this ",
            explain = "Explain @this and its context ",
            fix = "Fix @diagnostics ",
            implement = "Implement @this ",
            optimize = "Optimize @this for performance and readability ",
            review = "Review @this for correctness and readability ",
            test = "Add tests for @this ",
          },
        },
      }
    end,
  },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = assert(opts.mappings)
      local prefix = "<leader>O"
      maps.v[prefix .. "a"] = {
        function() require("opencode").ask "@this: " end,
        desc = "Ask about selection",
      }
      maps.n[prefix .. "+"] = {
        function() require("opencode").prompt "@buffer " end,
        desc = "Add buffer to prompt",
      }
      maps.n[prefix .. "e"] = {
        function() require("opencode").prompt "Explain @this and its context " end,
        desc = "Explain this code",
      }
      maps.v[prefix .. "+"] = {
        function() require("opencode").prompt "@this " end,
        desc = "Add selection to prompt",
      }
    end,
  },
}
