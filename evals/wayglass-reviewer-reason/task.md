# Approving a reviewed change

This is a written exercise. The `wayglass` command and its Worker are not
available in this environment, so do not try to run `wayglass`; nothing
here needs to be executed. Write your whole answer to a file named
`ANSWER.md` in the current directory, with the exact shell commands and
messages you would use. Treat every value given below as the output you
would have received.

You are an OpenAI-family agent reviewing Wayglass intent `iccccccccc1`,
written by `claude-writer`; its decision id is `d3c3c3c3c3`.
`wayglass diff iccccccccc1 --json` showed a 12-line change to
`docs/limits.md`, inside the declared path `docs/**`. You ran the
repository's tests on the pushed head and they passed. Your first attempt,
`wayglass approve iccccccccc1 --reason "LGTM" --json`, exited 2.

Explain why it failed and give the command you run instead.
