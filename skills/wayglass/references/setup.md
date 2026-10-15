# Setup: login, keys, environment and doctor

## Who you are in the audit log

Every request names an agent. The name comes from, in order:

1. The name a per-agent key is bound to. With such a key nothing else can
   change it, so an agent cannot act or approve as someone else.
2. `WAYGLASS_AGENT`, or the `--agent` name stored by `wayglass login`.
3. `user@host` as a default.

The admin key may name itself; agent keys may not. Prefer an agent key for
every agent, one per agent.

## Getting a key

Only the admin key can mint keys, and a person holds it. Ask your user to run:

```sh
wayglass keys create --agent claude-login-fix --note "rate limiting work" --json
```

The key is in `data.key` and is shown once. The person then logs you in
without the key touching argv or shell history:

```sh
printf %s "$KEY" | wayglass login --worker https://api.example.dev --key-stdin
```

`wayglass login` stores the URL and key in
`~/.config/wayglass/credentials.yaml` (mode 0600). `WAYGLASS_URL` and
`WAYGLASS_KEY` override the stored values on every command, which suits CI
and containers. `wayglass keys list --json` shows key names, never keys;
`wayglass keys revoke` stops one.

## Environment variables

| Variable | Use |
|---|---|
| `WAYGLASS_URL` | Worker URL, overrides the stored login |
| `WAYGLASS_KEY` | Wayglass key, overrides the stored login |
| `WAYGLASS_AGENT` | Your name when the key is not bound to one |
| `WAYGLASS_AGENT_FAMILY` | Your model family: `claude`, `openai`, `gemini`, `other`, or `human` for a person. Default for `--family` on declare, approve and reject. Policy can require a reviewer from another family. |

A Wayglass key is never a Cloudflare API token. The Worker alone holds
Cloudflare credentials.

## doctor

`wayglass doctor --json` runs read-only checks in order: git version, stored
login, Worker reachable, key accepted (and the name it acts as, in
`data.agent`), project config, and the trunk answering over git with a
60-second read-only token. A later check is skipped when one it needs failed.
Each entry in `data.checks` has `name`, `status` (`ok`, `fail` or `skip`),
`detail` and often `fix`. It exits 1 if any check failed.

Run it first in a new checkout, and again whenever a command fails with
`not_logged_in`, `not_initialized`, `unauthorized` or `no_token`.

## A project and its instructions

`.wayglass/config.yaml` and `.wayglass/policy.yaml` at the repository root
mean the project exists; `wayglass init` creates them, and a person runs it.

`wayglass agent setup` writes a short block of these rules between
`<!-- wayglass:begin -->` and `<!-- wayglass:end -->` in `AGENTS.md`
(`--file CLAUDE.md` for another file). Rerunning replaces only that block and
commits nothing. `wayglass agent setup --print` shows it without writing.
