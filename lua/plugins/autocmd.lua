local C = require "colors.color"

local hl_map = {
  everforest = {},
  catppuccin = { bg = C.lavender, fg = C.surface0, bold = true },
}

local function get_hl(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, create = false })
  if not ok or vim.tbl_isempty(hl) then
    -- 如果获取失败，返回安全默认值
    return { bg = "NONE", fg = "NONE" }
  end
  return hl
end

local function apply_custom_highlights()
  ---@type string
  local theme = vim.g.colors_name
  local hl = {}
  -- 💠 设置透明补全菜单
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE", blend = 0 }) -- 补全菜单透明
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = C.ice_white, bg = "NONE" }) -- 边框保留

  for key, value in pairs(hl_map) do
    -- 如果主题配置的为空table，则直接返回，不继续进行配置
    if theme:find(key) then
      if vim.tbl_isempty(value) then return end
      hl = value
      break
    end
  end
  -- 设置默认的补全菜单选中颜色，默认使用 catppuccin 的颜色
  vim.api.nvim_set_hl(0, "PmenuSel", hl) -- 选中项

  -- vim.api.nvim_set_hl(0, "CurSearch", {
  --   bg = C.mint_cream,
  --   fg = C.surface0,
  --   bold = true,
  -- }) -- 搜索当前项
end

--- 对于 catppuccin 主题，重新设置一下 flash.nvim 的配色
local function apply_flash_highlights_for_catppuccin()
  local hl = { bg = C.lavender, fg = C.surface0, bold = true }
  ---@type string
  local theme = vim.g.colors_name
  if theme:find "catppuccin" then vim.api.nvim_set_hl(0, "FlashLabel", { bg = C.lavender, fg = C.surface0 }) end
end

local function update_neotree_cursor_highlight(focused)
  -- 使用补全菜单的选中背景色来填充 neo-tree 选中，保持一致性
  local menu_sel_hl = get_hl "PmenuSel"
  if focused then
    -- vim.api.nvim_set_hl(0, "NeotreeCursorLine", { bg = C.lavender, fg = C.surface0, bold = true })
    vim.api.nvim_set_hl(0, "NeotreeCursorLine", menu_sel_hl)
  else
    vim.api.nvim_set_hl(0, "NeotreeCursorLine", get_hl "CursorLine")
  end
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      custom_highlights = {
        {
          event = "ColorScheme",
          callback = function()
            apply_custom_highlights()
            apply_flash_highlights_for_catppuccin()
          end,
        },
        {
          event = { "WinEnter", "BufEnter" },
          callback = function()
            local filetype = vim.bo.filetype
            if filetype == "neo-tree" then update_neotree_cursor_highlight(true) end
          end,
        },
        {
          event = { "WinLeave", "BufLeave" },
          callback = function()
            local filetype = vim.bo.filetype
            if filetype == "neo-tree" then update_neotree_cursor_highlight(false) end
          end,
        },
      },
    },
  },
}
