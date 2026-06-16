#!/usr/bin/env bash
#
# random-spinner-verbs.sh
#
# Picks a random verb list from this repo's verbs/ directory and writes it into
# Claude Code's `spinnerVerbs` setting. Intended to run as a SessionStart hook
# so every new Claude session gets a different themed spinner.
#
# It is deliberately defensive: if anything required is missing it exits 0
# without touching settings.json, so a moved/deleted repo never breaks startup.
set -euo pipefail

# Locate verbs/ relative to this script, so it works wherever the repo is cloned.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERBS_DIR="$SCRIPT_DIR/../verbs"

# Claude config dir (honor override, else the default ~/.claude).
CONFIG_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
SETTINGS="$CONFIG_DIR/settings.json"

# Bail out quietly if prerequisites are missing — never clobber existing config.
command -v jq >/dev/null 2>&1 || exit 0
[ -f "$SETTINGS" ] || exit 0
[ -d "$VERBS_DIR" ] || exit 0

# Collect the verb files.
shopt -s nullglob
files=("$VERBS_DIR"/*.txt)
shopt -u nullglob
[ "${#files[@]}" -gt 0 ] || exit 0

# Pick one at random.
if command -v shuf >/dev/null 2>&1; then
  pick="$(printf '%s\n' "${files[@]}" | shuf -n 1)"
else
  pick="${files[RANDOM % ${#files[@]}]}"
fi

# Rewrite spinnerVerbs atomically. rtrimstr drops the trailing newline so the
# last verb isn't an empty string. Rewriting the whole object via jq preserves
# every other key (permissions, enabledPlugins, hooks, ...).
tmp="$(mktemp)"
if jq --rawfile raw "$pick" \
  '.spinnerVerbs = {mode: "replace", verbs: ($raw | rtrimstr("\n") | split("\n"))}' \
  "$SETTINGS" > "$tmp"; then
  mv "$tmp" "$SETTINGS"
else
  rm -f "$tmp"
fi

exit 0
