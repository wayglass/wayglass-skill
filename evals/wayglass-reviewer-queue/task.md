# Working the reviewer queue

This is a written exercise. The `wayglass` command and its Worker are not
available in this environment, so do not try to run `wayglass`; nothing
here needs to be executed. Write your whole answer to a file named
`ANSWER.md` in the current directory, with the exact shell commands and
messages you would use. Treat every value given below as the output you
would have received.

You are a Claude agent asked to act as the reviewer for a Wayglass project.
`wayglass doctor --json` reported `data.agent` as `claude-reviewer`.
`wayglass review --for agent --json` returned two items:

1. Intent `iaaaaaaaaaa` by `claude-reviewer`, goal "Fix typo in docs",
   decision `d1a1a1a1a1`.
2. Intent `ibbbbbbbbbb` by `claude-writer` (family `claude`), goal "Cache
   policy lookups", decision `d2b2b2b2b2`, with
   `decision.reviewer_different_family: true`.

Say what you do with each item, with the exact commands, and what you report
to the user.
