---@param sources table
---@return table
local function order_sources(sources)
  local order_table = {}
  local max_index = table.maxn(sources) + 1
  for index, value in ipairs(sources) do
    order_table[value] = max_index - index
  end
  return order_table
end

--- print(require("nvim-treesitter.ts_utils").get_node_at_cursor():type())
--- print(require("nvim-treesitter.ts_utils").get_node_at_cursor():parent():type())

local function need_show_complete()
  local row, column = unpack(vim.api.nvim_win_get_cursor(0))
  local success, node = pcall(vim.treesitter.get_node, {
    pos = { row - 1, math.max(0, column - 1) },
    ignore_injections = false,
  })
  local signs = { "comment", "string" }
  if success and node then
    for _, value in ipairs(signs) do
      if node:type():find(value) then return false end
    end
  end
  return true
end

return {
  "saghen/blink.cmp",
  -- enabled = false,
  dependencies = {
    "onsails/lspkind.nvim",
    "xzbdmw/colorful-menu.nvim",
    -- "L3MON4D3/LuaSnip",

    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = "make install_jsregexp",
    },
  },
  opts = function(_, opts)
    ---@type blink.cmp.KeymapConfig
    opts.keymap = {
      preset = "super-tab",
    }
    -- require("astrocore").list_insert_unique(opts.sources.default, { "dadbod" })
    -- opts.sources.default = { "lazydev", "lsp", "dadbod", "avante", "snippets", "path", "emoji" }
    opts.sources.default = { "lazydev", "lsp", "dadbod", "snippets", "path", "emoji" }
    -- opts.sources.default = { "lsp", "dadbod", "avante", "path", "emoji", "lazydev" }
    opts.signature = { enabled = false }
    local order_table = order_sources(opts.sources.default)

    return require("astrocore").extend_tbl(opts, {
      ---@type blink.cmp.KeymapConfig
      keymap = {
        ["<C-d>"] = {
          function(cmp)
            -- if cmp.is_documentation_visible() and vim.fn.mode "i" then cmp.scroll_documentation_down(4) end
            -- if cmp.is_signature_visible() and vim.fn.mode "i" then cmp.scroll_signature_down(4) end
            if vim.fn.mode "i" then
              if cmp.is_documentation_visible() then cmp.scroll_documentation_down(4) end
            end
          end,
        },
        ["<C-u>"] = {
          function(cmp)
            -- if cmp.is_documentation_visible() and vim.fn.mode "i" then cmp.scroll_documentation_up(4) end
            -- if cmp.is_signature_visible() and vim.fn.mode "i" then cmp.scroll_signature_up(4) end
            if vim.fn.mode "i" then
              if cmp.is_documentation_visible() then cmp.scroll_documentation_up(4) end
            end
          end,
        },
      },
      ---@type blink.cmp.SourceConfig
      ---@diagnostic disable:missing-fields
      sources = {
        per_filetype = { sql = { "dadbod" } },
        providers = {
          dadbod = { module = "vim_dadbod_completion.blink" },
          -- avante = {
          --   module = "blink-cmp-avante",
          --   name = "Avante",
          -- },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          -- snippets = {
          --   otps = {
          --     friendly_snippets = false,
          --   },
          -- },
        },
      },
      ---@type blink.cmp.CompletionConfig
      ---@diagnostic disable:missing-fields
      completion = {
        list = {
          selection = { preselect = true, auto_insert = false },
        },
        menu = {
          auto_show = true,
          -- auto_show = function() return need_show_complete() end,
          -- auto_show = function() return need_show_complete_v2() end,
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  return require("lspkind").symbol_map[ctx.kind] or ""
                  -- return require("lspkind").symbolic(ctx.kind, {
                  --   mode = "symbol",
                  -- })
                end,
              },
              label = {
                text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
                highlight = function(ctx) return require("colorful-menu").blink_components_highlight(ctx) end,
              },
            },
            columns = {
              {
                "kind_icon",
              },
              {
                "label",
                -- "label_description",
                "kind",
                gap = 5,
              },
            },
          },
        },
      },
      ---@type blink.cmp.SnippetsConfig
      -- snippets = {
      --   preset = "luasnip",
      --   active = function(filter)
      --     local snippet = require "luasnip"
      --     local blink = require "blink.cmp"
      --     if snippet.in_snippet() and blink.is_visible() then
      --       return true
      --     else
      --       if not snippet.in_snippet() and vim.fn.mode() == "n" then
      --         snippet.unlink_current()
      --         vim.snippet.stop()
      --       end
      --       return false
      --     end
      --   end,
      -- },
      cmdline = {
        enabled = true,
        completion = {
          menu = {
            auto_show = function(ctx) return vim.fn.getcmdtype() == ":" end,
          },
        },
        keymap = {
          preset = "inherit",
        },
      },
      fuzzy = {
        sorts = {
          function(a, b)
            -- local a_order_id = order[a.source_id]
            -- local b_order_id = order[b.source_id]
            local a_order_id = order_table[a.source_id]
            local b_order_id = order_table[b.source_id]
            if a_order_id == nil or b_order_id == nil then return end
            if a_order_id ~= b_order_id then return a_order_id > b_order_id end
          end,
          "score",
          "sort_text",
        },
      },
      -- signature = { enabled = false },
      -- signature = {
      --   enabled = true,
      --   window = {
      --     show_documentation = false,
      --   },
      -- },
    })
  end,
}
