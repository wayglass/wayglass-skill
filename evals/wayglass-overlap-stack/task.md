# An overlap after a push

You are working on Wayglass intent `i1111111111` ("Add lockout after five
failed logins"). `wayglass push --json` returns one overlap:

```json
{"intent_id": "i2222222222", "goal": "Rate limit login", "agent": "codex-1",
 "status": "open", "paths": [{"mine": "web/login.ts", "theirs": "web/login.ts"}],
 "replan": {"action": "stack", "first": "i2222222222", "then": "i1111111111",
            "paths": ["web/login.ts"], "summary": "stack i1111111111 on i2222222222; both edited web/login.ts",
            "command": "wayglass intent restack i1111111111 --on i2222222222 --reason \"<why i1111111111 builds on i2222222222>\"",
            "suggested": true}}
```

Say what this means for you and what you do next, with the exact commands.
