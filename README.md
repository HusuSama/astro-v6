# Neovim 配置说明

这是一套基于 [AstroNvim](https://astronvim.com/) **v6** 的个人 Neovim 配置，使用 Lazy.nvim 管理插件，并通过 AstroCommunity 组合语言、调试、测试、编辑和界面能力。

当前版本在 `lua/lazy_setup.lua` 中固定为：

```lua
{
  "AstroNvim/AstroNvim",
  version = "^6",
  import = "astronvim.plugins",
}
```

## 配置结构

```text
init.lua                    启动 Lazy.nvim 并加载主配置
lua/lazy_setup.lua          AstroNvim v6、Leader 键和插件入口
lua/community.lua           AstroCommunity 语言包与插件模块
lua/plugins/init.lua        按类别导入自定义插件配置
lua/plugins/core/           选项、快捷键、自动命令、界面基础配置
lua/plugins/completion/     Blink.cmp 与 LuaSnip
lua/plugins/lsp/            LSP、语言专用配置和签名提示
lua/plugins/debug/          DAP 调试配置
lua/plugins/format/         Conform 格式化配置
lua/plugins/test/           vim-test 配置
lua/plugins/editor/         编辑辅助插件
lua/plugins/search/         Telescope、Snacks、Grug Far
lua/plugins/explorer/       Neo-tree 与 Yazi
lua/plugins/terminal/       ToggleTerm
lua/plugins/database/       Dadbod
lua/plugins/runner/         Overseer
lua/plugins/ui/             主题与界面配置
lua/plugins/ai/             Claude Code、OpenCode 等 AI 集成
lua/utils.lua               快捷键恢复和 LSP Snippet 公共函数
```

`lua/plugins/init.lua` 会显式导入各配置目录。停用或仅供参考的配置应放在 `lua/plugins/` 之外，避免被 Lazy.nvim 自动加载；本项目将旧的 nvim-cmp 配置放在 `lua/disabled/`，并明确禁用了 nvim-cmp 和 aerial.nvim。

## 自定义快捷键

以下只列出本项目新增或修改的常用快捷键。AstroNvim 和 AstroCommunity 自带快捷键可通过 which-key、`:map`、`:nmap`、`:imap` 等命令查看。

### 普通模式

| 快捷键                   | 功能                                |
| ------------------------ | ----------------------------------- |
| `<C-s>`                  | 保存当前文件                        |
| `<C-a>`                  | 全选当前缓冲区                      |
| `<A-h>` / `<A-l>`        | 上一个 / 下一个缓冲区               |
| `<Leader>bD`             | 选择并关闭缓冲区                    |
| `d`、`dd`、`D`、`x`、`X` | 删除但不写入默认寄存器              |
| `<C-\>`                  | 打开或关闭浮动终端                  |
| `<F7>`                   | 打开或关闭高度为 25 的水平终端      |
| `<F10>`                  | 在右侧打开或关闭 Overseer           |
| `<Leader>fT`             | 使用 Telescope 搜索 TODO            |
| `<Leader>Tl`             | 将 TODO 写入位置列表                |
| `<Leader>Tq`             | 将 TODO 写入 quickfix 列表          |
| `]t` / `[t`              | 跳到下一个 / 上一个 TODO            |
| `<Leader>fj`             | 使用 Telescope 查看跳转列表         |
| `g/`                     | 使用 Snacks 全局搜索文本            |
| `<Leader>tw`             | 翻译当前内容或可视选择              |
| `<Leader>-`              | 用 Yazi 打开当前文件所在位置        |
| `<Leader>yc`             | 用 Yazi 打开 Neovim 当前工作目录    |
| `<Leader>ZM`             | 切换 Zen Mode                       |
| `<Leader>MW`             | 在 Markdown 文件中启动 `markmap -w` |
| `<A-j>` / `<A-k>`        | 跳到下一个 / 上一个函数开头         |
| `ga`                     | 调用 EasyAlign 对齐                 |

`<F12>` 和 `<C-F12>` 当前只会提示 aerial.nvim 已禁用，不会打开符号大纲。

### 插入、命令行、可视与终端模式

| 模式   | 快捷键            | 功能                           |
| ------ | ----------------- | ------------------------------ |
| 插入   | `<C-h>` / `<C-l>` | 光标左移 / 右移                |
| 插入   | `<C-v>` / `<D-v>` | 从系统剪贴板粘贴               |
| 插入   | `<C-z>`           | 撤销                           |
| 插入   | `<C-s>`           | 保存当前文件                   |
| 插入   | `<C-k>`           | 将当前行滚动到窗口中央         |
| 命令行 | `<C-h>` / `<C-l>` | 光标左移 / 右移                |
| 命令行 | `<C-v>`           | 从系统剪贴板粘贴               |
| 可视   | `<C-c>` / `<D-c>` | 复制选择内容                   |
| 可视   | `d`               | 删除但不写入默认寄存器         |
| 终端   | `<Esc><Esc>`      | 返回普通模式                   |
| 终端   | `<C-S-q>`         | 返回普通模式                   |
| 终端   | `<C-w>`           | 先返回普通模式，再执行窗口命令 |

### 插件内特殊快捷键

#### Blink.cmp 与 LuaSnip

补全使用 [Blink.cmp](https://cmp.saghen.dev/) 的 `super-tab` 预设：

| 快捷键              | 功能                                                           |
| ------------------- | -------------------------------------------------------------- |
| `<Tab>` / `<S-Tab>` | 在补全项或 Snippet 跳转点之间向前 / 向后移动                   |
| `<C-d>` / `<C-u>`   | 补全文档窗口向下 / 向上滚动 4 行；文档不可见时回退到原按键行为 |
| `<C-Enter>`         | 展开 LuaSnip 或跳到下一个 Snippet 节点                         |

Blink.cmp 的补全源顺序为 `lazydev`、`lsp`、`dadbod`、`snippets`、`path`、`emoji`；SQL 文件只使用 Dadbod 补全源。命令行补全已启用，其中 `:` 命令会自动显示候选菜单。

#### Telescope

Telescope 插入模式中，`<C-j>` 和 `<C-n>` 选择下一项，`<C-k>` 和 `<C-p>` 选择上一项。

#### vim-visual-multi

插件默认映射已关闭，当前使用以下显式映射：

| 快捷键                | 功能                             |
| --------------------- | -------------------------------- |
| `<C-LeftMouse>`       | 在鼠标位置增加光标               |
| `<C-RightMouse>`      | 选择鼠标位置单词并增加光标       |
| `<Leader>ma`          | 在当前位置增加光标               |
| `<A-Down>` / `<A-Up>` | 向下 / 向上增加光标              |
| `<A-n>`               | 选择光标下的子词并进入多光标编辑 |

#### DAP 调试时的按键覆盖

DAP 会在调试会话启动后临时覆盖三个普通模式快捷键：

| 快捷键      | 调试期间功能 |
| ----------- | ------------ |
| `<A-Down>`  | 单步跳过     |
| `<A-Right>` | 单步进入     |
| `<A-Left>`  | 单步跳出     |

其中 `<A-Down>` 平时属于 vim-visual-multi。配置会在调试开始前记录全局映射，并在断开、终止或退出调试会话时恢复原映射，避免永久破坏多光标快捷键。

#### Dadbod 与 Neo-tree

| 场景                        | 快捷键      | 功能           |
| --------------------------- | ----------- | -------------- |
| SQL、MySQL、PL/SQL 可视模式 | `<C-Enter>` | 执行选中的查询 |
| Neo-tree                    | `<S-Enter>` | 展开全部节点   |
| Yazi                        | `<F8>`      | 显示 Yazi 帮助 |

Neo-tree 的删除操作已改为移动到系统回收站，而不是直接永久删除。

## LSP 配置

### 启用语言支持

语言能力主要通过 `lua/community.lua` 中的 AstroCommunity pack 启用。当前包括 Lua、Java、Vue、Rust、Python、HTML/CSS、Tailwind CSS、TypeScript、TOML、YAML、Go、Thrift、Prettier、golangci-lint、oxlint 和 Dadbod。

新增语言时，优先在 `lua/community.lua` 中导入对应 pack，例如：

```lua
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.typescript" },
}
```

如果 AstroCommunity 没有对应 pack，可在 `lua/plugins/lsp/servers.lua` 的 `AstroNvim/astrolsp` 配置中添加服务器：

```lua
return {
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        example_ls = {
          settings = {
            example = {
              enabled = true,
            },
          },
        },
      },
    },
  },
}
```

服务器可通过 `:Mason` 安装，通过 `:LspInfo`、`:checkhealth vim.lsp` 和 `:LspLog` 检查状态。

### 当前服务器定制

`lua/plugins/lsp/servers.lua` 中包含以下调整：

- `gopls`：关闭 `ST1003` 分析。
- `vtsls`：启用 `autoUseWorkspaceTsdk`，优先使用项目 TypeScript SDK。
- `emmet_ls`：仅用于 HTML。
- `tailwindcss`：识别 `tw`、`clsx` 和 `tw.*` 形式的 class 函数。
- `rust_analyzer`：忽略常见大型目录，并使用客户端文件监视，减少 Roots Scanned 卡顿。
- `sqls`：禁用存在问题的文档和范围格式化能力。
- `jdtls`：如果存在 macOS 路径 `/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home/bin/java`，优先使用该 Java 21。
- `make-ls`：打开 Makefile 时按需启动，需要先执行 `go install github.com/owenrumney/make-ls/cmd/make-ls@latest`。

LSP 引用、定义、实现、类型定义和工作区符号仍沿用 AstroNvim 的快捷键，但选择界面已替换为 Snacks Picker。

### 格式化

Conform 在保存时自动格式化，超时时间为 500 毫秒；没有匹配的外部格式化器时回退到 LSP 格式化：

```lua
format_on_save = {
  timeout = 500,
  lsp_format = "fallback",
}
```

## 启用 Snippet

这里需要区分两类 Snippet：

- **本地 Snippet**：由 Blink.cmp 的 `snippets` 补全源和 LuaSnip 提供，当前已启用。
- **LSP Snippet**：由语言服务器返回，例如函数参数占位符；本配置默认关闭，需要按项目显式开启。

### 本地 LuaSnip

Blink.cmp 使用 LuaSnip 作为 Snippet 引擎：

```lua
snippets = {
  preset = "luasnip",
}
```

自定义 Lua Snippet 放在以下目录：

```text
~/.config/nvim/lua/snippets/
```

加载逻辑位于 `lua/plugins/completion/luasnip.lua`。当前还将 `javascriptreact` Snippet 扩展给 JavaScript 文件：

```lua
require("luasnip").filetype_extend("javascript", { "javascriptreact" })
```

如果目录尚不存在，可以新建类似 `lua/snippets/lua.lua` 的文件：

```lua
local ls = require "luasnip"

return {
  ls.snippet("req", {
    ls.text_node 'local ',
    ls.insert_node(1, "name"),
    ls.text_node ' = require "',
    ls.insert_node(2, "module"),
    ls.text_node '"',
  }),
}
```

### LSP Snippet 开关

支持按项目为所有服务器开启：

```lua
vim.g.lsp_snippet_support = true
```

也可以只为指定服务器开启：

```lua
vim.g.lsp_snippet_support = {
  gopls = true,
  jdtls = true,
  lua_ls = true,
  rust_analyzer = true,
}
```

当前统一处理的服务器包括：

```text
cssls、emmet_ls、golangci_lint_ls、gopls、html、jsonls、jdtls、lua_ls、
ruff、rust_analyzer、sqls、tailwindcss、ty、volar、vtsls、yamlls
```

开关由 `lua/utils.lua` 在 LSP 初始化时读取。修改后需执行 `:LspRestart` 或重新打开 Neovim，已经启动的客户端不会自动更新。

特殊行为如下：

- `gopls` 始终保留 Blink.cmp 声明的 `snippetSupport = true`，确保函数补全仍可插入括号；开关实际控制 `gopls.usePlaceholders`。
- `lua_ls` 开关会同步控制 `callSnippet` 和 `keywordSnippet`。
- `rust_analyzer` 开关会在 `fill_arguments` 与 `none` 之间切换函数参数 Snippet。

## 使用 exrc 为项目单独配置 LSP

全局配置已经设置 `vim.opt.exrc = true`，Neovim 会查找并执行项目目录中的 `.nvim.lua`。Neovim 的 exrc 使用信任机制，首次使用项目配置前必须审查文件，并通过 `:trust` 授权。

推荐的项目结构：

```text
项目根目录/
├── .nvim.lua
└── .nvim/
    └── lsp/
        └── <server_name>.lua
```

### 1. 添加项目运行时目录

在项目根目录创建 `.nvim.lua`：

```lua
local source = debug.getinfo(1, "S").source:sub(2)
vim.opt.runtimepath:append(vim.fs.dirname(source) .. "/.nvim")

vim.g.lsp_snippet_support = {
  gopls = true,
}
```

或者直接

```lua
vim.opt.runtimepath:append(".nvim")
```

这会把项目的 `.nvim` 目录追加到 `runtimepath`，同时只为当前项目的 `gopls` 开启 LSP Snippet。

### 2. 创建项目级 LSP 配置

Neovim 0.11 及以上会从运行时目录的 `lsp/<server_name>.lua` 读取服务器配置。例如创建 `.nvim/lsp/gopls.lua`：

```lua
return {
  settings = {
    gopls = {
      buildFlags = { "-tags=integration" },
      analyses = {
        unusedparams = true,
      },
    },
  },
}
```

文件名必须与 LSP 客户端名称一致，例如 `gopls.lua`、`vtsls.lua`、`lua_ls.lua` 或 `rust_analyzer.lua`。

另外，你可以进行其他配置，比如当前项目的 `java` 版本低于 `jdtls` 的版本，需要指定 `jdk` 路径，可以给 `jdtls` 指定 JDK 路径，但是需要放到 `.nvim.lua` 下：

```lua
--- .nvim.lua
local jdtls_java = "/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home/bin/java"
local project_java = "/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"

--- 获取 lazy.nvim 中的 jdtls 插件，如果没有则直接退出
local plugin = require("lazy.core.config").plugins["nvim-jdtls"]
if not plugin then
  return
end

--- 获取 lazy.nvim 中关于 jdtls 的 opts 配置
local opts = require("lazy.core.plugin").values(plugin, "opts", false)

if vim.fn.executable(jdtls_java) == 1 and opts.cmd then
  opts.cmd[1] = jdtls_java
end

if vim.fn.executable(project_java .. "/bin/java") == 1 then
  opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
    java = {
      configuration = {
        runtimes = {
          { name = "JavaSE-17", path = project_java, default = true },
        },
      },
    },
  })
end
```

### 3. 信任配置并重启 LSP

首次进入项目后执行：

```vim
:trust
:LspRestart
```

修改 `.nvim.lua` 后通常需要重新进入 Neovim，因为 exrc 在启动和目录切换过程中加载；只修改 `.nvim/lsp/*.lua` 时也建议执行 `:LspRestart`。

不要信任来源不明的 `.nvim.lua`。该文件可以执行任意 Lua 代码，应像审查项目脚本一样先检查内容。

## 其他自定义配置

- 界面主题使用 `catppuccin-macchiato`，并保留多套 AstroCommunity 主题方便切换。
- 同时启用绝对行号和相对行号；进入插入模式或窗口失焦时关闭相对行号，返回普通模式后恢复。
- 默认不换行，启用系统剪贴板、忽略大小写搜索和自动缩进，并将连字符视为关键字字符。
- 大文件阈值设为 256 KiB 或 10000 行，交由 AstroCore 降级部分高开销功能。
- 禁用 netrw、gzip、tar、zip 和 tohtml 等运行时插件。
- Treesitter 预装 Lua、Python、Go、Rust、Markdown、YAML、TOML 和 Java 解析器。
- LSP 签名插件保留签名能力，但关闭独立浮动窗口。
- Overseer 任务默认隐藏运行，并且启动任务时不自动打开任务面板。
- vim-test 为 Go 测试追加 `-v -count=1`，为 Rust 测试追加 `-- --nocapture --include-ignored`。
- Neovide 关闭光标和滚动动画、输入时隐藏鼠标，并将 macOS 左右 Option 键作为 Meta 键。
- OpenCode 使用 Snacks Terminal 在右侧启动 `opencode --port`；Claude Code 快捷键统一位于 `<Leader>A` 前缀下。

## 常用维护命令

| 命令                   | 用途                                   |
| ---------------------- | -------------------------------------- |
| `:Lazy`                | 查看、安装和更新插件                   |
| `:Mason`               | 安装和管理 LSP、格式化器、调试器等工具 |
| `:LspInfo`             | 查看当前缓冲区的 LSP 客户端            |
| `:LspRestart`          | 重启 LSP 客户端                        |
| `:checkhealth`         | 检查 Neovim 和插件运行环境             |
| `:checkhealth vim.lsp` | 检查内置 LSP 状态                      |
| `:ConformInfo`         | 查看当前格式化器                       |
| `:TSUpdate`            | 更新 Treesitter 解析器                 |

可在终端中执行以下命令验证配置能否无界面启动：

```shell
nvim -i NONE --headless '+qa'
nvim -i NONE --headless '+lua vim.cmd("Lazy load all")' '+qa'
```

## 参考资料

- [AstroNvim 官网](https://astronvim.com/)
- [Blink.cmp 官网](https://cmp.saghen.dev/)
