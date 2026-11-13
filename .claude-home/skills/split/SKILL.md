---
name: split
description: Fork this conversation into an independent Claude session in a new Rex pane
argument-hint: "[right|left|above|below|tab] [message for the fork]"
disable-model-invocation: true
allowed-tools: Bash(~/.claude/skills/split/split.sh:*)
---

```!
~/.claude/skills/split/split.sh "${CLAUDE_SESSION_ID}" <<'__SPLIT_ARGS__'
$ARGUMENTS
__SPLIT_ARGS__
```

The conversation was forked into a new Rex pane (output above). Reply with one short line confirming it, or report the error. Do nothing else; carry on in this pane as before.
