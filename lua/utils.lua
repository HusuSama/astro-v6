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

---@param mode string
function M.record_global_mappings(mode)
  M.global_mode = mode
  M.global_mappings = {}
  for _, mapping in ipairs(vim.api.nvim_get_keymap(mode)) do
    local lhs = vim.api.nvim_replace_termcodes(mapping.lhs, true, true, true)
    M.global_mappings[lhs] = mapping
  end
end

-- run record_global_mappings first
---@param keys table
---@param opts? vim.keymap.set.Opts
function M.reset_default_global_keymaps(keys, opts)
  for _, key in ipairs(keys) do
    local normalized_key = vim.api.nvim_replace_termcodes(key, true, true, true)
    local mapping = M.global_mappings[normalized_key]
    if mapping then
      vim.keymap.set(M.global_mode, key, M.parse_command(mapping), vim.tbl_extend("force", opts or {}, {
        desc = mapping.desc,
        expr = mapping.expr == 1,
        nowait = mapping.nowait == 1,
        remap = mapping.noremap == 0,
        silent = mapping.silent == 1,
      }))
    else
      pcall(vim.keymap.del, M.global_mode, key)
    end
  end
  M.global_mappings = nil
  M.global_mode = nil
end

return M
