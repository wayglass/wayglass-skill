# wayglass-skill

Agent skills for working through Wayglass. Every command, flag, JSON field
and exit code in a skill must match the `wayglass` CLI. If the skill and the
CLI disagree, the CLI is right and the skill is wrong.

## Layout

```
skills/<name>/SKILL.md        the skill (frontmatter plus body)
skills/<name>/references/     detail loaded on demand
skills/<name>/agents/         Codex display metadata
skills/<name>/LICENSES/       MIT text, so an installed skill keeps its terms
evals/<name>-<scenario>/      eval scenarios (task.md, criteria.json)
scripts/cli-surface.txt       commands and flags, generated from --help
scripts/snapshot-cli.sh       regenerates cli-surface.txt from a wayglass binary
scripts/check.sh              command, dash and link checks
.claude-plugin/plugin.json    lets the repo install as a Claude Code plugin
skills.sh.json                skill groupings for skills.sh
```

## Rules for editing a skill

1. Verify before you write: `wayglass <command> --help`, then the source in
   `wayglass/wayglass` (`internal/cli/` for the CLI, `worker/src/` for the
   Worker's refusals). Never invent a command, flag or field.
2. Regenerate `scripts/cli-surface.txt` when the CLI changes, and say which
   commit you built from in the skill's Sources section.
3. Frontmatter carries only `name`, `description` and `license`. Double quote
   the description, keep it under 1024 characters, and say when to use the
   skill and when not to.
4. Keep SKILL.md short: rules, an ordered workflow that ends in a check, and
   the failure table. Put field lists and setup detail in `references/`, one
   level deep, each linked from SKILL.md.
5. Never put a real key, token, project name or person's name in an example.
6. No em dashes or en dashes anywhere.
7. No marketing copy, and never name or compare other tools.

## Checking your work

```sh
skillforge validate .
skillforge check .
```

Build Skillforge from the vendored copy with
`go -C .skill-quality build -o /tmp/skillforge .`. Do not edit
`.skill-quality/` by hand; update it with `skillforge install . --update`.

## Commits

Conventional commits whose message says why. One skill per commit where
possible.
