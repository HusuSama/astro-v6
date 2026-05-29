local M = {}

---@param key vim.api.keyset.get_keymap
---@return string | function
function M.parse_command(key)
  if key.rhs == nil then
    if key.callback == nil then return "" end
    return key.callback
  end
  return key.rhs
end

---@param mode
function M.record_global_mappings(mode)
  M.global_mode = mode
  M.global_mappings = vim.api.nvim_get_keymap(mode)
end

-- run record_global_mappings first
---@param keys table
---@param opts? vim.keymap.set.Opts
function M.reset_default_global_keymaps(keys, opts)
  for index, mapping in ipairs(M.global_mappings) do
    local normalized_default_key = vim.api.nvim_replace_termcodes(mapping.lhs, true, true, true)
    for index, key in ipairs(keys) do
      local normalized_key = vim.api.nvim_replace_termcodes(key, true, true, true)
      if normalized_key == normalized_default_key then
        local command = M.parse_command(mapping)
        vim.keymap.set(M.global_mode, key, command, opts)
      end
    end
  end
end

return M
