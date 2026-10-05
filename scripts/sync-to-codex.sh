#!/usr/bin/env bash
# Mirror the global Claude Code agent setup into Codex.
# ~/.claude is the source of truth; edit there, then run this.
set -euo pipefail

src="$HOME/.claude"
dst="$HOME/.codex"

# Skills: .system (Codex-managed) and synced (Claude-managed) are excluded,
# and excluded paths are never deleted on the Codex side.
rsync -a --delete --exclude '.system' --exclude 'synced' "$src/skills/" "$dst/skills/"

cp "$src/CLAUDE.md" "$dst/AGENTS.md"

echo "Synced skills and AGENTS.md to $dst"
