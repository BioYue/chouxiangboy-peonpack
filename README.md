# 抽象圣经四件套 · chouxiangboy-peonpack

> 给 Claude Code 装上一个"精神状态稳定"的中文音效苦工。
>
> A fan-made Chinese meme sound pack for [peon-ping](https://github.com/PeonPing/peon-ping).

这是一个 [peon-ping](https://github.com/PeonPing/peon-ping) 音效包,当 Claude Code 完成任务、报错、等待输入或你刷屏时,会随机播放"抽象圣经"里的四句经典:

| MP3            | 标签   | 触发事件           | 你会在什么时候听到                   |
| -------------- | ------ | ------------------ | ------------------------------------ |
| `wodedaodun`   | 我的刀盾 | `task.complete`    | Claude 完成一个任务                  |
| `bagayalu`     | 八嘎呀路 | `task.error`       | 任务执行报错                         |
| `bibilabu`     | 比比拉布 | `input.required`   | Claude 停下来等你输入/确认           |
| `bababoyi`     | 巴巴博一 | `user.spam`        | 你短时间内连续触发多次(默认 10s 内 3 次) |

---

## ⚠️ 版权声明(请先读)

本仓库收录的音频素材来自中文互联网 meme 合集("抽象圣经"),版权归各原作者所有,本仓库**仅做打包分发以便个人娱乐使用**,**不提供任何商业授权**。

- `sounds/*.mp3` — "Personal use only — fan-made compilation"
- 本仓库其它部分(`install.sh` / `README.md` 等)可在 MIT 精神下自由取用

如你是原素材版权方,希望下架相关音频,请提 issue 告知,我会尽快处理。

---

## 前置条件:先装 peon-ping

本包依赖 [peon-ping](https://github.com/PeonPing/peon-ping)(一个给 Claude Code / Codex / Cursor 等 CLI 播放音效和系统通知的 hook 工具)。

如果你还没装,先装它:

```bash
# 官方一键脚本(macOS / Linux / WSL)
curl -fsSL https://peonping.com/install.sh | bash
```

装完后应该能在命令行执行 `peon --version`。

---

## 一键安装(推荐)

```bash
git clone https://github.com/<your-username>/chouxiangboy-peonpack.git
cd chouxiangboy-peonpack
./install.sh
```

脚本会自动:
1. 检查你已经装好 `peon` 命令
2. 调用 `peon packs install-local` 把当前目录作为音效包复制到 `~/.claude/hooks/peon-ping/packs/chouxiang_shengjing/`(或 `~/.openpeon/packs/`)
3. 调用 `peon packs use chouxiang_shengjing` 自动激活

如果你已经装过一次,想覆盖更新:

```bash
./install.sh --force
```

---

## 手动安装(备选)

如果你不想执行第三方 shell 脚本,也可以直接用 peon-ping 官方命令:

```bash
git clone https://github.com/<your-username>/chouxiangboy-peonpack.git
peon packs install-local ./chouxiangboy-peonpack
peon packs use chouxiang_shengjing
```

---

## 验证装好了

```bash
peon packs list
# 输出里应该能看到 chouxiang_shengjing,并带有 "active" 或 ✓ 标记
```

然后让 Claude Code 跑一个随便的任务,任务结束那一刻你就会听到"我的刀盾"。

---

## 卸载

```bash
peon packs remove chouxiang_shengjing
```

---

## 目录结构

```
chouxiangboy-peonpack/
├── README.md
├── install.sh              # 一键安装脚本
├── openpeon.json           # CESP v1.0 manifest
├── sounds/
│   ├── bababoyi.mp3
│   ├── bagayalu.mp3
│   ├── bibilabu.mp3
│   └── wodedaodun.mp3
└── .gitignore
```

---

## 致谢

- [peon-ping](https://github.com/PeonPing/peon-ping) —— 提供了整个音效 hook 生态和 CESP 包格式
- 抽象圣经原作者们 —— 互联网文化的一股清流
