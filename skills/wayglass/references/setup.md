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

`wayglass login` stores the Worker URL and the key in its own file under
`~/.config/wayglass/` (mode 0600; `WAYGLASS_CONFIG_DIR` moves the
directory). `WAYGLASS_URL` and `WAYGLASS_KEY` override the stored values on
every command, which suits CI and containers. `wayglass keys list --json`
shows key names, never keys; `wayglass keys revoke` stops one.

People log in differently: `wayglass login --human` goes through the
browser (`--no-browser` prints the URL) and `wayglass keys create --human`
mints a key for a person. Only a person's login can decide a change routed
to a person (`pending_human`, `quarantined`); an agent key gets
`needs_human` there, exit 4.

## Environment variables

| Variable | Use |
|---|---|
| `WAYGLASS_URL` | Worker URL, overrides the stored login |
| `WAYGLASS_KEY` | Wayglass key, overrides the stored login |
| `WAYGLASS_AGENT` | Your name when the key is not bound to one |
| `WAYGLASS_AGENT_FAMILY` | Your model family: `claude`, `openai`, `gemini`, `meta`, `other`, or `human` for a person (aliases such as `anthropic`, `gpt`, `google` and `llama` map to these). Default for `--family` on declare, approve and reject. Policy can require a reviewer from another family. |
| `WAYGLASS_PROJECT`, `WAYGLASS_INTENT` | Override the project and the current intent that `.wayglass/` in the checkout would supply |
| `WAYGLASS_CONFIG_DIR` | Where the login file lives, instead of `~/.config/wayglass` |

A Wayglass key is never a Cloudflare API token. The Worker alone holds
Cloudflare credentials.

## Where the CLI comes from

`wayglass` is the open source command-line tool of the same project as
these skills, MIT licensed, at <https://github.com/wayglass/wayglass>.
Release archives for macOS, Linux and Windows are on that repository's
Releases page with a `checksums.txt`; the macOS ones are Developer ID
signed and notarized. Install it with the installer line in the Wayglass
README or build it from source with `go build ./cmd/wayglass`. Do not take
the binary from anywhere else.

## doctor

`wayglass doctor --json` runs read-only checks in order, named in
`data.checks[].name`: `git` (version), `login` (a stored login),
`permissions` (the login file's mode), `session` (a person's login not yet
expired), `worker` (reachable), `auth` (key accepted, and the name it acts
as, in `data.agent`), `project` (config present), `helper` (the git
credential helper) and `trunk` (answers over git with a 60-second read-only
token). A later check is skipped when one it needs failed. Each entry has
`status` (`ok`, `warn`, `fail` or `skip`), `detail` and often `fix`. It
exits 1 if any check failed; a `warn` leaves the exit at 0.

Run it first in a new checkout, and again whenever a command fails with
`not_logged_in`, `not_initialized`, `unauthorized` or `no_token`.

## A project and its instructions

`.wayglass/config.yaml` and `.wayglass/policy.yaml` at the repository root
mean the project exists; `wayglass init` creates them, and a person runs it.
Writes under `.wayglass/` refuse symlinks (`unsafe_path`).

`wayglass agent setup` writes a short block of these rules between
`<!-- wayglass:begin -->` and `<!-- wayglass:end -->` in `AGENTS.md`
(`--file CLAUDE.md` for another file). Rerunning replaces only that block and
commits nothing. `wayglass agent setup --print` shows it without writing.
Where the block and this skill differ on re-stacking, use
`wayglass intent restack`, which keeps the intent id.
