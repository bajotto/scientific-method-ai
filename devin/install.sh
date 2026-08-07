#!/usr/bin/env bash
# Installs the global SessionStart hook that injects this method into
# every Devin CLI session on this machine, in any project — no
# per-project configuration needed.
#
# Usage: ./install.sh
set -euo pipefail

if ! command -v jq >/dev/null 2>&1; then
  echo "ERROR: jq is required and was not found. Install it first:" >&2
  echo "  Debian/Ubuntu: sudo apt-get install -y jq" >&2
  echo "  macOS:         brew install jq" >&2
  exit 1
fi

DEVIN_DIR="$HOME/.devin"
DOCS_DIR="$DEVIN_DIR/scientific-method"
HOOKS_DIR="$DEVIN_DIR/hooks"
HOOKS_CONFIG="$DEVIN_DIR/hooks.v1.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
METHOD_DIR="$(cd "$SCRIPT_DIR/../method" && pwd)"

mkdir -p "$DOCS_DIR" "$HOOKS_DIR"

# 1. Copy the global docs (warn instead of overwriting if a different
#    version already exists)
for doc in SCIENTIFIC_METHOD.md ENFORCEMENT_MODEL.md; do
  dest="$DOCS_DIR/$doc"
  if [ -f "$dest" ] && ! diff -q "$METHOD_DIR/$doc" "$dest" >/dev/null 2>&1; then
    echo "WARNING: $dest already exists and differs from this package — not overwriting."
    echo "         Review manually: diff '$METHOD_DIR/$doc' '$dest'"
  else
    cp "$METHOD_DIR/$doc" "$dest"
    echo "OK  $dest"
  fi
done

# 2. Copy the hook script
cp "$SCRIPT_DIR/hooks/session-start-protocol-global.sh" "$HOOKS_DIR/session-start-protocol-global.sh"
chmod +x "$HOOKS_DIR/session-start-protocol-global.sh"
echo "OK  $HOOKS_DIR/session-start-protocol-global.sh"

# 3. Merge into hooks.v1.json. This file's schema is NOT the same as
#    Claude Code's settings.json: the event name is a top-level key, and
#    each entry has "matcher" + "hooks". Preserves any existing hooks
#    (including hooks for other events) and is idempotent.
if [ ! -f "$HOOKS_CONFIG" ]; then
  echo '{}' > "$HOOKS_CONFIG"
fi

HOOK_CMD="bash $HOOKS_DIR/session-start-protocol-global.sh"

TMP="$(mktemp)"
jq --arg cmd "$HOOK_CMD" '
  .SessionStart //= [] |
  (
    if ([.SessionStart[].hooks[]?.command] | index($cmd)) then
      .
    else
      .SessionStart += [{
        matcher: "",
        hooks: [{ type: "command", command: $cmd, timeout: 15 }]
      }]
    end
  )
' "$HOOKS_CONFIG" > "$TMP"
mv "$TMP" "$HOOKS_CONFIG"
echo "OK  $HOOKS_CONFIG (hook registered, rest of the file preserved)"

echo
echo "Done. Confirmed working pattern (tested against a real Devin CLI"
echo "session, not assumed): run 'devin -p \"...\"' in any project on this"
echo "machine and ask it to quote something from ENFORCEMENT_MODEL.md."
echo
echo "This guarantees the docs are DELIVERED to every session. It does not"
echo "guarantee they are FOLLOWED — see ../method/ENFORCEMENT_MODEL.md."
echo
echo "For project-specific critical rules (not just this global method),"
echo "use ../devin/rules/PROJECT_RULE_TEMPLATE.md instead — per-project"
echo "Windsurf-format rules, which is a separate mechanism from this hook."
