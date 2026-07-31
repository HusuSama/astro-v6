local prefix = "<leader>A"

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { prefix, nil, desc = "Claude Code" },
    { prefix .. "<CR>", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { prefix .. "<CR>", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    { prefix .. "c", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { prefix .. "f", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { prefix .. "r", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { prefix .. "C", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { prefix .. "m", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { prefix .. "b", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { prefix .. "s", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      prefix .. "s",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },
    -- Diff management
    { prefix .. "a", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { prefix .. "d", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
