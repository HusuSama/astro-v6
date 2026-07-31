local function extend_iskeyword(...)
  local keys = vim.opt.iskeyword:get()
  vim.list_extend(keys, { ... })
  return keys
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      highlighturl = true,
      notifications = true,
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        exrc = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        clipboard = "unnamedplus",
        ignorecase = true,
        autoindent = true,
        iskeyword = extend_iskeyword "-",
      },
      o = {
        jumpoptions = "stack",
      },
      g = {
        mapleader = " ",
        icons_enabled = true,
        move_key_modifier = "",
        move_key_modifier_visualmode = "S",
        mundo_right = 1,
        mundo_close_on_revert = 1,
        mundo_width = 80,
      },
    },
  },
}
