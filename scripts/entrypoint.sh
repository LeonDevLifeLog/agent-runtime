#!/usr/bin/env bash
# 运行时按需换国内镜像源——镜像本身保持中立。
# 设 CN_MIRROR=1（或 true/yes/on）启用；不设则直接透传，零行为。
# chsrc 自动测速选最快镜像；任何一步失败只告警，绝不阻断容器启动。
set -e

_truthy() {
  case "$(printf '%s' "${1:-}" | tr '[:upper:]' '[:lower:]')" in
    1|true|yes|on) return 0 ;;
    *) return 1 ;;
  esac
}

if _truthy "${CN_MIRROR:-}"; then
  echo "[entrypoint] CN_MIRROR=on，chsrc 自动换源中…" >&2
  # 系统级（apt，需 root）
  sudo chsrc set ubuntu || echo "[entrypoint] warn: chsrc set ubuntu 失败，跳过" >&2
  # 用户级（写 \$HOME 配置，勿用 sudo）
  #   python => pip + uv (+poetry/pdm)    node => npm + pnpm (+yarn)
  for t in python node go maven brew; do
    chsrc set "$t" || echo "[entrypoint] warn: chsrc set $t 失败，跳过" >&2
  done
fi

exec "$@"
