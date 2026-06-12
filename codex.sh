#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd -P || pwd)"

if [ -f "$script_dir/claude.sh" ]; then
  exec "$script_dir/claude.sh" "$@" --agent codex
fi

if [ -n "${TDL_SKILL_REPO_URL:-}" ]; then
  tmp_root="$(mktemp -d)"
  cleanup() {
    rm -rf "$tmp_root"
  }
  trap cleanup EXIT

  branch="${TDL_SKILL_BRANCH:-main}"
  archive="$tmp_root/tdl-skill.tar.gz"
  repo_archive="${TDL_SKILL_REPO_URL%/}/archive/refs/heads/${branch}.tar.gz"

  curl -fsSL "$repo_archive" -o "$archive"
  tar -xzf "$archive" -C "$tmp_root"
  installer="$(find "$tmp_root" -maxdepth 2 -type f -name claude.sh -print -quit)"
  [ -n "$installer" ] || {
    printf 'Error: downloaded archive did not contain claude.sh\n' >&2
    exit 1
  }

  exec "$installer" "$@" --agent codex
fi

printf 'Error: cannot find claude.sh. Run this from the TDL-Skill repo or set TDL_SKILL_REPO_URL.\n' >&2
exit 1
