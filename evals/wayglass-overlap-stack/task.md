# An overlap after a push

This is a written exercise. The `wayglass` command and its Worker are not
available in this environment, so do not try to run `wayglass`; nothing
here needs to be executed. Write your whole answer to a file named
`ANSWER.md` in the current directory, with the exact shell commands and
messages you would use. Treat every value given below as the output you
would have received.

You are working on Wayglass intent `i1111111111` ("Add lockout after five
failed logins"). `wayglass push --json` returned one overlap:

```json
{"intent_id": "i2222222222", "goal": "Rate limit login", "agent": "codex-1",
 "status": "open", "paths": [{"mine": "web/login.ts", "theirs": "web/login.ts"}],
 "replan": {"action": "stack", "first": "i2222222222", "then": "i1111111111",
            "paths": ["web/login.ts"], "summary": "stack i1111111111 on i2222222222; both edited web/login.ts",
            "command": "wayglass intent restack i1111111111 --on i2222222222 --reason \"<why i1111111111 builds on i2222222222>\"",
            "suggested": true}}
```

Say what this means for you and what you do next, with the exact commands.
