-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- 删除luasnip映射方法
-- local function remove_tab()
--   vim.api.nvim_buf_del_keymap(0, "i", "<Tab>")
--   vim.api.nvim_buf_del_keymap(0, "i", "<S-Tab>")
-- end
--
-- local function call_remove() pcall(remove_tab) end

local function number_toggle()
  local augroup = vim.api.nvim_create_augroup("numbertoggle", {})
  vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
    pattern = "*",
    group = augroup,
    callback = function()
      if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then vim.opt.relativenumber = true end
    end,
  })

  vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
    pattern = "*",
    group = augroup,
    callback = function()
      if vim.o.nu then
        vim.opt.relativenumber = false
        -- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
        -- Workaround for https://github.com/neovim/neovim/issues/32068
        if not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then vim.cmd "redraw" end
      end
    end,
  })
end

return {
  -- 对 terminal界面简化操作，ESC回到普通模式，直接可以切换窗口
  vim.api.nvim_create_autocmd({ "TermOpen" }, {
    group = vim.api.nvim_create_augroup("term_mapping", { clear = true }),
    pattern = "term://*",
    callback = function()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<C-S-q>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end,
  }),

  number_toggle(),

  -- 自定义LuaSnip跳转快捷键
  -- InsertEnter set tab to jump next
  -- InsertLeave delete tab keymap
  -- vim.api.nvim_create_autocmd("InsertEnter", {
  --   group = vim.api.nvim_create_augroup("snip_mapping", { clear = true }),
  --   pattern = "*",
  --   callback = function()
  --     local snip = require "luasnip"
  --     if snip.in_snippet() then
  --       vim.api.nvim_buf_set_keymap(
  --         0,
  --         "i",
  --         "<Tab>",
  --         [[<cmd>lua require("luasnip").jump(1)<cr>]],
  --         { silent = true, noremap = true }
  --       )
  --       vim.api.nvim_buf_set_keymap(
  --         0,
  --         "i",
  --         "<S-Tab>",
  --         -- snip.jump(-1),
  --         [[<cmd>lua require("luasnip").jump(-1)<cr>]],
  --         { silent = true, noremap = true }
  --       )
  --     end
  --   end,
  -- }),
  -- vim.api.nvim_create_autocmd("InsertLeave", {
  --   group = vim.api.nvim_create_augroup("del_snip_mapping", { clear = true }),
  --   pattern = "*",
  --   callback = call_remove,
  -- }),

  -- vim.api.nvim_create_autocmd("InsertLeave", {
  --   group = vim.api.nvim_create_augroup("del_active_snip", { clear = true }),
  --   pattern = "*",
  --   callback = function()
  --     local lp = require "luasnip"
  --     if not lp.in_snippet() then lp.unlink_current() end
  --   end,
  -- }),
}
