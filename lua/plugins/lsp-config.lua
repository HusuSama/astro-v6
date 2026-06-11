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
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = false,
              analyses = { ST1003 = false },
            },
          },
        },
        vtsls = {
          root_dir = function()
            local git_root = get_git_root()
            if git_root ~= nil then return git_root end
          end,
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
            },
          },
        },
        emmet_ls = { filetypes = "html" },
        -- prettierd = { filetypes = "html" },
        tailwindcss = {
          settings = {
            tailwindCSS = {
              classFunctions = { "tw", "clsx", "tw\\.[a-z-]+" },
            },
          },
        },
      },
    },
  },
}
