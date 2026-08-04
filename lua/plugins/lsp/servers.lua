local snippet_servers = {
  "cssls",
  "emmet_ls",
  "golangci_lint_ls",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "ruff",
  "rust_analyzer",
  "sqls",
  "tailwindcss",
  "ty",
  "volar",
  "vtsls",
  "yamlls",
}

return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local utils = require "utils"
      opts.config = opts.config or {}
      for _, server in ipairs(snippet_servers) do
        opts.config[server] = opts.config[server] or {}
        local configure_snippets = utils.configure_lsp_snippets(server)
        opts.config[server].before_init = astrocore.patch_func(opts.config[server].before_init, function(orig, ...)
          orig(...)
          configure_snippets(...)
        end)
      end

      return astrocore.extend_tbl(opts, {
        config = {
          gopls = {
            settings = {
              gopls = {
                analyses = { ST1003 = false },
              },
            },
          },
          lua_ls = {
            settings = {
              Lua = {
                completion = {},
              },
            },
          },
          rust_analyzer = {
            settings = {
              ["rust-analyzer"] = {
                completion = {
                  callable = {},
                },
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
      })
    end,
  },
}
