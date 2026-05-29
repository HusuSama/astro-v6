---@return string | nil
local function get_git_root()
  local handler = io.popen "git rev-parse --show-toplevel"
  if handler == nil then return nil end
  ---@type string
  local output = handler:read "*a"
  local git_root = output:gsub("[\n\r]", "")
  -- skip if not a git repo
  if git_root:match "not a git repository" ~= nil then return nil end
  handler:close()
  return git_root
end

return {
  -- {
  --   "AstroNvim/astrolsp",
  --   ---@param opts AstroLSPOpts
  --   opts = function(_, opts)
  --     opts.handlers = opts.handlers or {}
  --     opts.handlers.emmet_ls = false
  --
  --     opts.servers = vim.tbl_filter(function(server)
  --       return server ~= "emmet_ls"
  --     end, opts.servers or {})
  --   end,
  -- },
  -- {
  --   "AstroNvim/astrolsp",
  --   ---@type AstroLSPOpts
  --   ---@diagnostic disable:missing-fields
  --   opts = {
  --     features = {
  --       inlay_hints = false,
  --       signature_help = false,
  --     },
  --     config = {
  --       vtsls = {
  --         -- root_dir = function() return "/Users/bytedance/VueProjects/frontend" end,
  --         root_dir = function()
  --           local git_root = get_git_root()
  --           if git_root ~= nil then return git_root end
  --         end,
  --         settings = {
  --           vtsls = {
  --             autoUseWorkspaceTsdk = true,
  --           },
  --         },
  --       },
  --       emmet_ls = { filetypes = "html" },
  --       -- prettierd = { filetypes = "html" },
  --       tailwindcss = {
  --         settings = {
  --           tailwindCSS = {
  --             classFunctions = { "tw", "clsx", "tw\\.[a-z-]+" },
  --           },
  --         },
  --       },
  --       gopls = {
  --         settings = {
  --           gopls = {
  --             analyses = { ST1003 = false },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = vim.tbl_filter(function(s) return s ~= "prettierd" end, opts.ensure_installed)
  --   end,
  -- },
}
