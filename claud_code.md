20 Claude Code隐藏命令

今天，分享用了一段时间 Claude Code，挑出了日常高频实用的命令,几 局
天都在用。许多时候，Claude Code 好不好用，很大程度取决于你知
不知道这些隐藏命令。
**1、/model [model]**

model opus，切换到 opus 模型
model opusplan, opus 负责深度思考和完整规划，自动切 Sonnet 执行
代码。

Claude Code

/model opusplan
L Set model to Opus 4.6 in plan mode, else Sonnet 4.6

这个命令对小白非常友好，质量最高，且省 token，也是社区公认"神
技“，几乎所有大项目第一步都
**2、/plan**开启之后，Claude Code 进入只读规划模式，这时候呢它只会
分析代码仓库，输出计划，思考，不会动你任何代码。
接手新项目，如刚入职想对复杂项目重构时，先 plan 再动手了。
**3、/fast**
这个命令，是开启高速模式，响应速度大幅提升，适合快速迭代和调试。
注意: Fast Mode 跑的还是同一个模型，只是 API 设置做了速度优化，成
本更高，用完记得关，不然 token MASI.
**4、/compac**t一键压缩上下文，可以带参数指定保留什么，比如
/compact 保留错误处理逻辑 。平时当上下文用量超过 80% 时必打
的，可以配合 /context 监控使用。

**5, /review**
写好的代码，准备提交时，可以先review代码审查，减少上线时bug，安
全，格式，性能等情况出现。改完代码后几乎会执行，以前是项目负责
人，现在换成claude review.

**6、/rewind**
有后悔药的命令，执行后可以安全回滚到上一个 checkpoint。比如修改
了代码出了问题直接撤回，不用手动 git reset，减少 git 学习成本

**7, /clear**
清空当前会话，重置所有上下文。比如要切换新任务时，执行改命令。

---

**9、/agents**

来管理子agent，比如在实现并行任务或多步循环。开启后，可以同时派出多个 AI AFA

立，并行推进。一个ai干完自动交接，不用你盯着，在大项目，复杂任务用这个能省很多时间。

**10、/doctor**

自动诊断环境，依赖，会话问题。遇到奇怪 bug 先跑这个。

**11、 /todos**

会列出当前会话中的 todo 项，任务管理神器啊。

**12、/diff**

查看代码变更，准备push代码时，确认修改前必看，也很常用。命令依赖 gh CLI，需要安装一下，

mac用户执行，授权就行: brew install gh && gh auth login

Welcome back!         Run /init to create a CLAUDE.md file with instru.

sre-tauri/tauri conf .json

**13、/help**
请求帮助，会显示所有可用命令，包括自定义命令。有很多隐藏功能都在这里找到14、/context
实时显示当前 token 使用率和上下文状态，防止爆内存，很实用的。

**15、 /security-review**

主要是对未提交的改动做安全审查。注意也是命令依赖 gh Cll<? 超级实用 Tips (1) /model opus 规划

> 确认计划 > /fast + Sonnet 执行一 /review 一 /diff 确认 一接受或 /rewind

规划阶段                                  /model opus
切换到 Opus，深度规划

|只读规划，不动代码

—"< 确认计划?
确认
wv

执行阶段                         |         /fast + Sonnet 执行
Beast, PRAT

—           wv

/review 一 /diff
代码审查，确认变更

一一一、
人 yY Accept 合

(2) 自定义 slash commands对于重度使用者，可以自定义命令。首先在项目根目录建 .claude/commands/
文件夹，放 .md 文件就能自己造命令了。文件名就是命令名。比如 refactor.md 就变成 /refactor。

(3) loop
该命令很有意思，如你告诉它"每隔 x 分钟，帮有我做一件事"，它就会一直循环做，不需要你手动触发。使用
场景如。

更多场景:
¢ /loop 5m /review: 每 5 分钟自动跑一次代码审查

。 /loop 每周检查依赖项漏洞
。 /loop 每隔186分钟提醒我，我的拉取请求是否已获批准并可以合并
。 /loop 每天上午9点深入研究AI在生产应用中的市场趋势

。 /loop 每天早晨循环检查ol1lama中最新未解决的问题并向我汇报

小迭代用 /fast +Sonnet, Opus 只用来规划，不仅省钱又高效，很实用组合涯。你最常用哪个命令?整理为一份清单，可保
存:

Claude Code                                                                       +
/model [model]           模型      切换模型。opus 规划, sonnet 执行, opusptan 自动切换
/plan              规划    只读规划模式，只分析输出计划，不动代码

/fast               速度     高速模式，快速迭代时用，成本更高，用完记得关
/compact 【说明]        LFX     压缩上下文。超 80% 时必打，可带参数指定保留
/context                   EEX.       实时显示 token 使用率，配合 /compact 使用

/clear             上下文    清空会话，重置所有上下文，切换任务时用

/rewind                 1088      回滚到上一个 checkpoint，代码改出问题直接撤回
/review [PRS]          Git     代码审查，检查安人全、格式、性能。提交前必跑?
/diff                    Git      查看代码变更，push 前确认用

/security-review       Git     对未提交改动做安全审查

/todos                        任务        列出当前会话的 todo 项

/agents                    多智能体      管理子 agent，并行派多个 Al 处理不同任务

/init                       项目       初始化项目，自动生成 CLAUDE.md 规范文件

/doctor            诊断    自动诊断环境和依赖问题，遇到 bug 先跑这个

/help              系统     显示所有可用命令，包括自定义命令

brew install gh && gh auth login

TIPS

自定义命令
Noop 循环任务

快捷键

其他人内置命令
命令
/cost
/memory
/mcp
/theme
/Login
/Logout
/hooks
/config
/ide
/add-dir
/pr-comments
/install-github-app
/terminal-setup
/plugin [命令]
/simplify
/batch [指令]
/export [文件名]

/bashes

= @ | WHR >> @ Claude Code > 20 个Claude Code隐藏命令 7

说明

/model opus 规划 一fastt Sonnet 执行 -review一 /diff
一接受 或/rewind

Opus RIM, Sonnet 执行。 /fas蔬完必须关

建 .ctaude/commands/ ，放.md 文件，文件名即命令名

/ loop 5m /review 每5分钟自动审查
/loop 每天检查依赖漏洞

Escape 停止; 双击 Escape 查看历史
Ctrl+V 粘贴图片; 拖文件按住 Shift

分类           说明
上下文        当前会话 token 用量统计
记忆        编辑 CLAUDE.md 记忆文件，管理跨会话持久知识
扩展        管理 MCP 服务器连接，添加/删除外部工具集成

界面         打开主题选择器，切换界面配色
ee         切换或重新登录 Anthropic 账号
账号         退出当前登录账号

自动化    配置自动化触发器 (格式化、类型检查、通知等)
系统     管理权限、认证和项目配置

系统       管理 IDE 集成 (VS Code, Cursor 等)

me         添加额外工作目录，适合 monorepo

Git         显示当前分支 PR 的评论

Git         安装 GitHub App, ik Claude 自动 review PR

系统     自动配置终端，解决兼容问题

扩展     管理插件市场，安装插件集合
多智能体       3 个 agent 并行审查，清理代码质量问题
多智能体    并行大规模代码修改，适合批量重构
系统     导出会话内容到文件或剪贴板

系统         查看后台运行任务状态
系统        向 Anthropic 报告 bug，附带会话上下文
系统        退出 Claude Code REPL
