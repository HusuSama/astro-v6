local M = {}

---@class ClipboardPosition
---@field line integer 1-based line number
---@field column integer 1-based byte column

---@class ClipboardSelection
---@field mode string Visual mode (`v`, `V`, or CTRL-V)
---@field start ClipboardPosition
---@field finish ClipboardPosition

---@class ClipboardFileContext
---@field path string Absolute file path
---@field root string? Project root detected by AstroCore
---@field relative_path string Project-relative path, or the absolute path when outside a project

local reference_prefix = "@"

---@param first ClipboardPosition
---@param second ClipboardPosition
---@return ClipboardPosition start
---@return ClipboardPosition finish
local function ordered_positions(first, second)
  if first.line < second.line or (first.line == second.line and first.column <= second.column) then
    return first, second
  end
  return second, first
end

---@param bufnr? integer
---@return ClipboardFileContext? context
---@return string? error
function M.file_context(bufnr)
  bufnr = bufnr or 0
  if bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end

  local rooter = require "astrocore.rooter"
  local path = rooter.bufpath(bufnr)
  if not path then return nil, "Current buffer has no file path" end

  local detected = rooter.detect(bufnr)
  local root = detected[1] and detected[1].paths[1] or nil
  local relative_path = root and vim.fs.relpath(root, path) or nil
  return {
    path = path,
    root = root,
    relative_path = (relative_path or path):gsub("\\", "/"),
  }
end

---@return ClipboardPosition
function M.cursor_position()
  local cursor = vim.api.nvim_win_get_cursor(0)
  return { line = cursor[1], column = cursor[2] + 1 }
end

---Get and normalize the endpoints of the active Visual selection.
---@return ClipboardSelection? selection
---@return string? error
function M.visual_selection()
  local mode = vim.fn.mode(1):sub(1, 1)
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then return nil, "No active Visual selection" end

  local anchor = vim.fn.getpos "v"
  local cursor = vim.fn.getcurpos()
  local start_pos, finish_pos = ordered_positions(
    { line = anchor[2], column = anchor[3] },
    { line = cursor[2], column = cursor[3] }
  )
  return { mode = mode, start = start_pos, finish = finish_pos }
end
---@param selection ClipboardSelection
function M.finish_visual_selection(selection)
  vim.cmd.normal { args = { "\27" }, bang = true }
  vim.api.nvim_win_set_cursor(0, { selection.start.line, math.max(selection.start.column - 1, 0) })
end

---@param context ClipboardFileContext
---@param location? ClipboardPosition|ClipboardSelection
---@return string
function M.format_reference(context, location)
  local reference = reference_prefix .. context.relative_path
  if not location then return reference end
  if location.start then return ("%s:%d-%d"):format(reference, location.start.line, location.finish.line) end
  return ("%s:%d:%d"):format(reference, location.line, location.column)
end

---@param text string
function M.copy(text)
  vim.fn.setreg("+", text)
  vim.notify("Copied " .. text)
end

---@param kind "file"|"line"|"column"|"selection"
function M.copy_reference(kind)
  local context, context_error = M.file_context()
  if not context then
    vim.notify(context_error, vim.log.levels.WARN)
    return
  end

  local reference
  if kind == "line" then
    local cursor = M.cursor_position()
    reference = ("%s:%d"):format(M.format_reference(context), cursor.line)
  elseif kind == "column" then
    reference = M.format_reference(context, M.cursor_position())
  elseif kind == "selection" then
    local selection, selection_error = M.visual_selection()
    if not selection then
      vim.notify(selection_error, vim.log.levels.WARN)
      return
    end
    reference = M.format_reference(context, selection)
    M.finish_visual_selection(selection)
  else
    reference = M.format_reference(context)
  end

  M.copy(reference)
end

return M
