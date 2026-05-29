return {
  "akinsho/toggleterm.nvim",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      direction = "float",
    })
  end,
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- local Terminal = require("toggleterm.terminal").Terminal
    --
    -- _G.opencode_term = nil
    --
    -- local function get_opencode_term()
    --   if not _G.opencode_term then
    --     _G.opencode_term = Terminal:new {
    --       cmd = "opencode",
    --       display_name = "opencode",
    --       direction = "vertical",
    --       hidden = true,
    --       on_open = function(term)
    --         vim.cmd "startinsert!"
    --         vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
    --       end,
    --     }
    --   end
    --   return _G.opencode_term
    -- end
    --
    -- function _G.opencode_toggle()
    --   local term = get_opencode_term()
    --   term:toggle(80)
    -- end
    --
    -- vim.api.nvim_set_keymap("n", "<leader>O", "<cmd>lua opencode_toggle()<cr>", { noremap = true, silent = true })
  end,
}
