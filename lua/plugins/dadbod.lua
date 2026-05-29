return {
  "kristijanhusak/vim-dadbod-ui",
  config = function()
    vim.g.db_ui_execute_on_save = 0
    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
      pattern = { "*.dbout" },
      callback = function()
        vim.api.nvim_exec2(
          [[
          exe ':resize 40'
          ]],
          {}
        )
      end,
    })
    vim.api.nvim_create_autocmd({ "FileType" }, {
      desc = "DBUIQuary",
      pattern = { "sql", "mysql", "plsql" },
      group = vim.api.nvim_create_augroup("DBUI", { clear = true }),
      callback = function()
        vim.api.nvim_buf_set_keymap(0, "v", "<C-Enter>", "<Plug>(DBUI_ExecuteQuery)", { silent = true, noremap = true })
      end,
    })
  end,
}
