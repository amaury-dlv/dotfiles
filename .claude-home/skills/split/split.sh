#!/bin/zsh
# Fork the current Claude conversation into a new Rex pane.
# Usage: split.sh SESSION_ID [right|left|above|below|tab] [message...]
#    or: echo "[direction] message" | split.sh SESSION_ID
set -euo pipefail

sid="${1:-}"; shift || true
[[ -z "$sid" ]] && sid="${CLAUDE_CODE_SESSION_ID:-}"
[[ -z "$sid" ]] && { echo "split: no session id" >&2; exit 1; }
[[ -z "${REX_SESSION:-}" ]] && { echo "split: not running inside Rex" >&2; exit 1; }

# Raw text: from args, or stdin (used by the skill so quotes etc. survive).
if (( $# )); then text="$*"; elif [[ ! -t 0 ]]; then text="$(cat)"; else text=""; fi
text="${text#"${text%%[![:space:]]*}"}"   # trim leading whitespace

dir=right
first="${text%%[[:space:]]*}"
case "$first" in right|left|above|below|tab)
  dir="$first"; text="${text#"$first"}"; text="${text#"${text%%[![:space:]]*}"}" ;;
esac
text="${text%"${text##*[![:space:]]}"}"   # trim trailing whitespace

cmd=(claude --dangerously-skip-permissions --resume "$sid" --fork-session)
[[ -n "$text" ]] && cmd+=("$text")

if [[ "$dir" == tab ]]; then
  rex run -s "$REX_SESSION" -c "$PWD" -- "${cmd[@]}" >/dev/null
else
  rex split -s "$REX_SESSION" ${REX_BLOCK:+-b "$REX_BLOCK"} --split="$dir" \
    --label fork -c "$PWD" -- "${cmd[@]}" >/dev/null
fi
where=$([[ $dir == tab ]] && echo "tab" || echo "pane ($dir)")
echo "Forked session $sid into a new Rex $where${text:+ with message: $text}"
