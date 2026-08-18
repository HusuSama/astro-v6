return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        ["<Leader>y"] = { desc = "复制引用" },
        ["<Leader>yf"] = {
          function() require("utils.clipboard").copy_reference "file" end,
          desc = "复制文件引用",
        },
        ["<Leader>yy"] = {
          function() require("utils.clipboard").copy_reference "line" end,
          desc = "复制行引用",
        },
        ["<Leader>yl"] = {
          function() require("utils.clipboard").copy_reference "column" end,
          desc = "复制行列引用",
        },
      },
      v = {
        ["<Leader>y"] = {
          function() require("utils.clipboard").copy_reference "selection" end,
          desc = "复制选择范围引用",
        },
      },
    },
  },
}
