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
          -- root_dir = function()
          --   local git_root = get_git_root()
          --   if git_root ~= nil then return git_root end
          -- end,
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
            },
          },
        },
        emmet_ls = { filetypes = { "html" } },
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
