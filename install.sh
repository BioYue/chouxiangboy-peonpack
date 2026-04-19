#!/usr/bin/env bash
# 抽象圣经四件套 - 一键安装脚本
# 前置:已安装 peon-ping (https://github.com/PeonPing/peon-ping)
# 用法:
#   ./install.sh            首次安装
#   ./install.sh --force    覆盖已存在的同名包

set -euo pipefail

PACK_NAME="chouxiang_shengjing"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

say()  { printf '\033[1;36m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[warn]\033[0m %s\n' "$*" >&2; }
die()  { printf '\033[1;31m[error]\033[0m %s\n' "$*" >&2; exit 1; }

command -v peon >/dev/null 2>&1 || die "未找到 peon 命令,请先安装 peon-ping:
  curl -fsSL https://peonping.com/install.sh | bash
  或查看 https://github.com/PeonPing/peon-ping"

[ -f "$SCRIPT_DIR/openpeon.json" ] || die "找不到 $SCRIPT_DIR/openpeon.json,请在仓库根目录运行本脚本"

say "安装音效包到 peon-ping: $PACK_NAME"
peon packs install-local "$SCRIPT_DIR" "$@"

say "激活音效包"
peon packs use "$PACK_NAME"

say "完成 🎉 下次 Claude Code 任务完成时将听到「我的刀盾」"
