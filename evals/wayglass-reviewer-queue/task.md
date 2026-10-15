# Working the reviewer queue

You are a Claude agent asked to act as the reviewer for a Wayglass project.
`wayglass doctor --json` says `data.agent` is `claude-reviewer`.
`wayglass review --for agent --json` returns two items:

1. Intent `iaaaaaaaaaa` by `claude-reviewer`, goal "Fix typo in docs".
2. Intent `ibbbbbbbbbb` by `claude-writer` (family `claude`), goal "Cache
   policy lookups", with `decision.reviewer_different_family: true`.

Say what you do with each item, with the exact commands, and what you report
to the user.
