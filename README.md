# 抽象圣经四件套 · chouxiangboy-peonpack

<p align="center">
  <img src="daodun.png" alt="我的刀盾" width="420" />
</p>

> 给 Claude Code 装上一个"精神状态稳定"的中文音效苦工。
>
> A fan-made Chinese meme sound pack for [peon-ping](https://github.com/PeonPing/peon-ping).

这是一个 [peon-ping](https://github.com/PeonPing/peon-ping) 音效包,当 Claude Code 完成任务、报错、等待输入或你刷屏时,会随机播放"抽象圣经"里的四句经典:

| MP3            | 标签     | 触发事件          | 你会在什么时候听到                          |
| -------------- | -------- | ----------------- | ------------------------------------------- |
| `wodedaodun`   | 我的刀盾 | `task.complete`   | Claude 完成一个任务                         |
| `bagayalu`     | 八嘎呀路 | `task.error`      | 任务执行报错                                |
| `bibilabu`     | 比比拉布 | `input.required`  | Claude 停下来等你输入/确认                  |
| `bababoyi`     | 巴巴博一 | `user.spam`       | 你短时间内连续触发多次(默认 10s 内 3 次) |

---

## 🚀 快速开始

### 1. 前置条件:先装 peon-ping

本包依赖 [peon-ping](https://github.com/PeonPing/peon-ping) —— 一个给 Claude Code / Codex / Cursor 等 CLI 播放音效和系统通知的 hook 工具。

```bash
# 官方一键脚本(macOS / Linux / WSL)
curl -fsSL https://peonping.com/install.sh | bash
```

装完后应该能执行 `peon --version`。

### 2. 一键安装(推荐)

```bash
git clone https://github.com/<your-username>/chouxiangboy-peonpack.git
cd chouxiangboy-peonpack
./install.sh
```

脚本会自动:

1. 检查 `peon` 命令是否已装好
2. 调用 `peon packs install-local` 把当前目录复制到 `~/.claude/hooks/peon-ping/packs/chouxiang_shengjing/`(或 `~/.openpeon/packs/`)
3. 调用 `peon packs use chouxiang_shengjing` 自动激活

已装过一次、想覆盖更新:

```bash
./install.sh --force
```

### 3. 手动安装(备选)

如果你不想执行第三方 shell 脚本,也可以直接用 peon-ping 官方命令:

```bash
git clone https://github.com/<your-username>/chouxiangboy-peonpack.git
peon packs install-local ./chouxiangboy-peonpack
peon packs use chouxiang_shengjing
```

### 4. 验证装好了

```bash
peon packs list
# 输出里应该能看到 chouxiang_shengjing,并带有 "active" 或 ✓ 标记
```

然后让 Claude Code 跑一个随便的任务,结束那一刻你会听到「我的刀盾」。

### 5. 卸载

```bash
peon packs remove chouxiang_shengjing
```

---

## 🔌 支持范围与配置方法

本音效包遵循 peon-ping 通用 **CESP v1.0** 格式,**任何 peon-ping 已适配的 AI CLI / IDE 都能用**。音效包本身不关心宿主是谁 —— 只要 peon-ping 能收到 hook 事件,本包就会出声。

> 以下示例里的 `~/.claude/hooks/peon-ping/adapters/xxx.sh` 是 peon-ping 的默认路径,如你装到自定义目录,请替换成 `$CLAUDE_PEON_DIR` 下的对应 adapter。
> 所有 adapter 源码与权威配置在 [PeonPing/peon-ping · adapters/](https://github.com/PeonPing/peon-ping/tree/main/adapters)。

<details>
<summary><b>Claude Code</b> · 无需手动配置</summary>

peon-ping 官方主打。运行官方安装脚本后 hook 会自动写入 `~/.claude/settings.json`。

- 参考:[peon-ping README](https://github.com/PeonPing/peon-ping) · [Claude Code Hooks](https://docs.claude.com/en/docs/claude-code/hooks)

</details>

<details>
<summary><b>Codex CLI</b> (OpenAI)</summary>

在 `~/.codex/config.toml` 里加:

```toml
notify = ["bash", "/Users/你的用户名/.claude/hooks/peon-ping/adapters/codex.sh"]
```

> 必须用**绝对路径**,Codex 不会展开 `~`。

</details>

<details>
<summary><b>Cursor IDE</b></summary>

在 `~/.cursor/hooks.json` 里加:

```json
{
  "hooks": [
    { "event": "stop",
      "command": "bash ~/.claude/hooks/peon-ping/adapters/cursor.sh stop" },
    { "event": "beforeShellExecution",
      "command": "bash ~/.claude/hooks/peon-ping/adapters/cursor.sh beforeShellExecution" }
  ]
}
```

</details>

<details>
<summary><b>Windsurf IDE</b> (Codeium Cascade)</summary>

在 `~/.codeium/windsurf/hooks.json` 里加:

```json
{
  "hooks": {
    "post_cascade_response": [
      { "command": "bash ~/.claude/hooks/peon-ping/adapters/windsurf.sh post_cascade_response", "show_output": false }
    ],
    "pre_user_prompt": [
      { "command": "bash ~/.claude/hooks/peon-ping/adapters/windsurf.sh pre_user_prompt", "show_output": false }
    ]
  }
}
```

</details>

<details>
<summary><b>Kiro CLI</b> (Amazon)</summary>

新建 `~/.kiro/agents/peon-ping.json`:

```json
{
  "hooks": {
    "agentSpawn":        [{ "command": "bash ~/.claude/hooks/peon-ping/adapters/kiro.sh" }],
    "userPromptSubmit":  [{ "command": "bash ~/.claude/hooks/peon-ping/adapters/kiro.sh" }],
    "stop":              [{ "command": "bash ~/.claude/hooks/peon-ping/adapters/kiro.sh" }]
  }
}
```

> 不要挂 `preToolUse` / `postToolUse`,每次工具调用都会触发,非常吵。

</details>

<details>
<summary><b>Gemini CLI</b></summary>

在你的 Gemini CLI settings 里注册 hook,命令指向:

```bash
bash ~/.claude/hooks/peon-ping/adapters/gemini.sh <EventType>
```

事件名:`SessionStart` / `AfterAgent` / `Notification`(由 Gemini CLI 自动传入)。

</details>

<details>
<summary><b>Kimi Code CLI</b> (MoonshotAI)</summary>

Kimi 没有 hook 系统,adapter 用**后台守护进程**监听 `~/.kimi/sessions/*/wire.jsonl`:

```bash
# 先装依赖
brew install fswatch           # macOS
sudo apt install inotify-tools # Linux

# 启动 / 查看 / 卸载
bash ~/.claude/hooks/peon-ping/adapters/kimi.sh --install
bash ~/.claude/hooks/peon-ping/adapters/kimi.sh --status
bash ~/.claude/hooks/peon-ping/adapters/kimi.sh --uninstall
```

</details>

<details>
<summary><b>Antigravity</b> (Google)</summary>

同样是后台 watcher,监听 `~/.gemini/antigravity/conversations/`:

```bash
brew install fswatch   # 或 sudo apt install inotify-tools
bash ~/.claude/hooks/peon-ping/adapters/antigravity.sh &    # 后台运行
```

</details>

<details>
<summary><b>Rovo Dev CLI</b> (Atlassian)</summary>

在 `~/.rovodev/config.yml` 里加:

```yaml
eventHooks:
  events:
    - name: on_complete
      commands:
        - command: bash ~/.claude/hooks/peon-ping/adapters/rovodev.sh on_complete
    - name: on_error
      commands:
        - command: bash ~/.claude/hooks/peon-ping/adapters/rovodev.sh on_error
    - name: on_tool_permission
      commands:
        - command: bash ~/.claude/hooks/peon-ping/adapters/rovodev.sh on_tool_permission
```

> 要用绝对路径,YAML 里 `~` 不一定展开。

</details>

<details>
<summary><b>DeepAgents CLI</b></summary>

在 `~/.deepagents/hooks.json` 里加:

```json
{
  "hooks": [
    {
      "command": ["bash", "/Users/你的用户名/.claude/hooks/peon-ping/adapters/deepagents.sh"],
      "events": ["session.start", "session.end", "task.complete", "input.required", "task.error", "tool.error", "user.prompt", "permission.request", "compact"]
    }
  ]
}
```

</details>

<details>
<summary><b>OpenCode</b></summary>

adapter 自己是个安装器,直接跑:

```bash
bash ~/.claude/hooks/peon-ping/adapters/opencode.sh
# 卸载
bash ~/.claude/hooks/peon-ping/adapters/opencode.sh --uninstall
```

</details>

<details>
<summary><b>OpenClaw</b></summary>

在你的 OpenClaw skill 里调用 adapter,或直接命令行触发:

```bash
bash ~/.claude/hooks/peon-ping/adapters/openclaw.sh <event>
# event 可选: session.start / task.complete / task.error / input.required / user.spam 等
```

</details>

> 本包 `language` 字段是 `zh-CN`,中文用户体感无差别;英文环境下只是音效语种为中文,不影响触发逻辑。

---

## 📁 目录结构

```
chouxiangboy-peonpack/
├── README.md
├── install.sh              # 一键安装脚本
├── openpeon.json           # CESP v1.0 manifest
├── daodun.png              # 核心 meme 图
├── sounds/
│   ├── bababoyi.mp3
│   ├── bagayalu.mp3
│   ├── bibilabu.mp3
│   └── wodedaodun.mp3
└── .gitignore
```

---

## 🙏 致谢

- [peon-ping](https://github.com/PeonPing/peon-ping) —— 提供了整个音效 hook 生态和 CESP 包格式
- 抽象圣经原作者们 —— 互联网文化的一股清流

---

## ⚠️ 版权声明

本仓库收录的音频素材来自中文互联网 meme 合集("抽象圣经"),版权归各原作者所有,本仓库**仅做打包分发以便个人娱乐使用**,**不提供任何商业授权**。

- `sounds/*.mp3` — "Personal use only — fan-made compilation"
- `daodun.png` — 网络流传 meme 图,版权归原作者
- 本仓库其它部分(`install.sh` / `README.md` 等)可在 MIT 精神下自由取用

如你是原素材版权方,希望下架相关音频或图片,请提 issue 告知,我会尽快处理。
