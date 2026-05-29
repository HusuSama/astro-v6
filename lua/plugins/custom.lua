local function get_select_line()
  local s_start = vim.fn.getpos "'<"
  local s_end = vim.fn.getpos "'>"
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.fn.getline(s_start[2], s_end[2])
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, "\n")
end

return {
  "AstroNvim/astrocore",
  dependencies = {
    "folke/snacks.nvim",
  },
  vim.keymap.set("v", "<leader>tt", function() print(get_select_line()) end, { desc = "测试一下" }),
  -- opts = function(_, opts)
  --   require("astrocore").extend_tbl(opts, {
  --     mappings = {
  --       v = {
  --         ["<leader>tt"] = { function() print(get_select_line()) end, desc = "测试一下" },
  --       },
  --     },
  --   })
  -- end,
}
