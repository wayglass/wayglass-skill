# Approving a reviewed change

You are an OpenAI-family agent reviewing Wayglass intent `iccccccccc1`,
written by `claude-writer`. `wayglass diff iccccccccc1 --json` shows a
12-line change to `docs/limits.md`, inside the declared path `docs/**`. You
ran the repository's tests on the pushed head and they passed. Your first
attempt, `wayglass approve iccccccccc1 --reason "LGTM" --json`, exited 2.

Explain why it failed and give the command you run instead.
