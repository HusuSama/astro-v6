return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require "dap", require "dapui"
      local utils = require "utils"
      local keys = {
        over = { key = "<A-Down>", newCmd = "<cmd>DapStepOver<cr>", oldCmd = "" },
        into = { key = "<A-Right>", newCmd = "<cmd>DapStepInto<cr>", oldCmd = "" },
        out = { key = "<A-Left>", newCmd = "<cmd>DapStepOut<cr>", oldCmd = "" },
      }
      utils.record_global_mappings "n"
      dap.listeners.before.launch.dapui_config = function()
        for _, value in pairs(keys) do
          vim.keymap.set("n", value.key, value.newCmd, { silent = true, noremap = true })
        end
        dapui.open()
      end
      dap.listeners.before.disconnect.dapui_config = function()
        local reset_keys = {}
        for _, value in pairs(keys) do
          table.insert(reset_keys, value.key)
        end
        utils.reset_default_global_keymaps(reset_keys, { silent = true, noremap = true })
        dapui.close()
      end
    end,
    opts = function(_, opts) require("astrocore").extend_tbl(opts, {}) end,
  },
}
