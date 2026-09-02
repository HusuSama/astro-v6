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
  local theme = vim.g.colors_name or ""
  local hl = {}
  -- 设置透明补全菜单
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE", blend = 0 })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = C.ice_white, bg = "NONE" })

  for key, value in pairs(hl_map) do
    if theme:find(key) then
      hl = value
      break
    end
  end
  -- Everforest 不覆盖补全菜单选中色；其他主题使用对应配置。
  if not vim.tbl_isempty(hl) then vim.api.nvim_set_hl(0, "PmenuSel", hl) end

  -- Everforest 已提供这些组，但显式链接可确保在禁用状态符号后，
  -- Neo-tree 的文件名仍按 Git 状态着色。
  if theme:find "everforest" then
    local git_highlights = {
      NeoTreeGitAdded = "Aqua",
      NeoTreeGitConflict = "Orange",
      NeoTreeGitDeleted = "Red",
      NeoTreeGitIgnored = "Grey",
      NeoTreeGitModified = "Blue",
      NeoTreeGitRenamed = "Purple",
      NeoTreeGitStaged = "Aqua",
      NeoTreeGitUnstaged = "Yellow",
      NeoTreeGitUntracked = "Yellow",
    }
    for group, target in pairs(git_highlights) do
      vim.api.nvim_set_hl(0, group, { link = target })
    end
  end
end

--- 对于 catppuccin 主题，重新设置一下 flash.nvim 的配色
local function apply_flash_highlights_for_catppuccin()
  local theme = vim.g.colors_name or ""
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
