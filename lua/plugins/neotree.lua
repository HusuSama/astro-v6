--- 获取移动到回收站的命令，Windows区别对待
------@param filepath string
------@return table
---local function get_move_file_to_trash_cmd(filepath)
---  if vim.fn.has "win32" == 1 then
---    return {
---      "powershell",
---      "-NoProfile",
---      "-Command",
---      (
---        "Add-Type -AssemblyName Microsoft.VisualBasic; "
---        .. "[Microsoft.VisualBasic.FileIO.FileSystem]::"
---        .. (vim.fn.isdirectory(filepath) == 0 and "DeleteFile" or "DeleteDirectory")
---        .. "('%s','OnlyErrorDialogs', 'SendToRecycleBin')"
---      ):format(filepath:gsub("\\", "\\\\"):gsub("'", "''")),
---    }
---  end
---  -- 默认使用 trash 进行删除操作（仅在macOS上进行过测试）
---  return { "trash", filepath }
---end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      local actions = require "snacks.explorer.actions"
      return require("astrocore").extend_tbl(opts, {
        window = {
          -- position = "float",
          width = 40,
          mappings = {
            ["<S-enter>"] = "expand_all_nodes",
          },
        },
        default_component_configs = {
          git_status = {
            symbols = {
              added = "",
              deleted = "",
              modified = "",
              renamed = "",
              untracked = "",
              ignored = "",
              unstaged = "",
              staged = "",
              conflict = "",
            },
          },
          diagnostics = {
            symbols = {
              hint = "",
              info = "",
              warn = "",
            },
          },
        },
        ---@type neotree.Config.Filesystem
        filesystem = {
          commands = {
            -- 删除操作不直接删除，而是放入回收站
            delete = function(state)
              local inputs = require "neo-tree.ui.inputs"
              local path = state.tree:get_node().path
              local msg = "Are you sure trash " .. path .. " ?"
              inputs.confirm(msg, function(confirmed)
                if not confirmed then return end
                local ok, err = actions.trash(vim.fn.fnameescape(path))
                if not ok then
                  vim.notify(err, vim.log.levels.ERROR)
                  return
                end
                require("neo-tree.sources.manager").refresh(state.name)
              end)
            end,
            delete_visual = function(state, selected_nodes)
              local inputs = require "neo-tree.ui.inputs"
              local count = #selected_nodes
              local msg = "Are you sure trash " .. count .. " files ?"
              inputs.confirm(msg, function(confirmed)
                if not confirmed then return end
                for _, node in ipairs(selected_nodes) do
                  local ok, err = actions.trash(vim.fn.fnameescape(node.path))
                  if not ok then
                    vim.notify(err, vim.log.levels.ERROR)
                    return
                  end
                end
                require("neo-tree.sources.manager").refresh(state.name)
              end)
            end,
            --   delete = function(state)
            --     local inputs = require "neo-tree.ui.inputs"
            --     local path = state.tree:get_node().path
            --     local msg = "Are you sure you want to trash" .. path .. " ?"
            --     inputs.confirm(msg, function(confirmed)
            --       if not confirmed then return end
            --       vim.fn.system(get_move_file_to_trash_cmd(vim.fn.fnameescape(path)))
            --       require("neo-tree.sources.manager").refresh(state.name)
            --     end)
            --   end,
            --   -- 多选模式下，删除也是移动到回收站，而非直接删除
            --   delete_visual = function(state, selected_nodes)
            --     local inputs = require "neo-tree.ui.inputs"
            --     -- get table items count
            --     function GetTableLen(tbl)
            --       local len = 0
            --       for n in pairs(tbl) do
            --         len = len + 1
            --       end
            --       return len
            --     end
            --
            --     local count = GetTableLen(selected_nodes)
            --     local msg = "Are you sure you want to trash" .. count .. "files ?"
            --     inputs.confirm(msg, function(confirmed)
            --       if not confirmed then return end
            --       for _, node in ipairs(selected_nodes) do
            --         vim.fn.system(get_move_file_to_trash_cmd(vim.fn.fnameescape(node.path)))
            --       end
            --       require("neo-tree.sources.manager").refresh(state.name)
            --     end)
            --   end,
          },
        },
      })
    end,
  },
}
