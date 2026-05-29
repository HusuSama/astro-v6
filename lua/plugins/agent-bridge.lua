return {
  "agent-bridge",
  name = "agent-bridge",
  dir = "/Users/bytedance/PythonProjects/agent-bridge",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    provider = "claude",
    terminal = {
      backend = "snacks",
      direction = "vertical",
      size = { width = 0.4, height = 0.8 },
      border = "rounded",
      auto_start = true,
    },
  },
  config = function(_, opts) require("agent_bridge").setup(opts) end,
  cmd = {
    "AgentStart",
    "AgentStop",
    "AgentAsk",
    "AgentAskThisFile",
    "AgentAskThisSelection",
    "AgentSendCurrentFile",
    "AgentSendCurrentSelection",
    "AgentSwitchProvider",
    "AgentPanelToggle",
  },
}
