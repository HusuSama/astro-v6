return {
  {
    "mfussenegger/nvim-dap",
    config = function(...)
      require("astronvim.plugins.configs.nvim-dap")(...)
      local dap = require "dap"
      local utils = require "utils"
      local keys = {
        over = { key = "<A-Down>", newCmd = "<cmd>DapStepOver<cr>", oldCmd = "" },
        into = { key = "<A-Right>", newCmd = "<cmd>DapStepInto<cr>", oldCmd = "" },
        out = { key = "<A-Left>", newCmd = "<cmd>DapStepOut<cr>", oldCmd = "" },
      }
      dap.listeners.after.event_initialized.custom_keys = function()
        utils.record_global_mappings "n"
        for _, value in pairs(keys) do
          vim.keymap.set("n", value.key, value.newCmd, { silent = true, noremap = true })
        end
      end
      local function cleanup()
        local reset_keys = {}
        for _, value in pairs(keys) do
          table.insert(reset_keys, value.key)
        end
        utils.reset_default_global_keymaps(reset_keys, { silent = true, noremap = true })
      end
      dap.listeners.before.disconnect.custom_keys = cleanup
      dap.listeners.before.event_terminated.custom_keys = cleanup
      dap.listeners.before.event_exited.custom_keys = cleanup
    end,
  },
}
