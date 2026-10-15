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
.tessl-plugin/plugin.json     Tessl registry manifest (wayglass/wayglass)
skills.sh.json                skill groupings for skills.sh
SECURITY.md                   how to report a problem; the independent reports
TODO.md                       what is left, with the evidence to look for
```

## Rules for editing a skill

1. Verify before you write: `wayglass <command> --help`, then the source in
   `wayglass/wayglass` (`internal/cli/` for the CLI, `worker/src/` for the
   Worker's refusals). Never invent a command, flag or field.
2. Regenerate `scripts/cli-surface.txt` when the CLI changes, and name the
   Wayglass release (tag and commit) you built from in the Source section
   at the end of the skill's main reference file; SKILL.md only points there. Do not name `scripts/cli-surface.txt` inside a skill: it is not
   in the installed skill directory, and every validator reports the path
   as a missing file.
3. Frontmatter carries only `name`, `description` and `license`. Double quote
   the description, keep it under 1024 characters, and say when to use the
   skill and when not to.
4. Keep SKILL.md short: rules, an ordered workflow that ends in a check, and
   the failure table. Put field lists and setup detail in `references/`, one
   level deep, each linked from SKILL.md.
5. Never put a real key, token, project name or person's name in an example.
6. No em dashes or en dashes anywhere.
7. No marketing copy, and never name or compare other tools.
8. Write descriptions in the third person ("Use when the user asks for a
   change to go through Wayglass"), with several trigger phrasings.
9. Keep reference prose free of credential file names and words such as
   "auto-approve"; the security scanners read them as credential access
   and unattended high-impact actions, whatever the sentence means.

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
possible. Bump the version in `.tessl-plugin/plugin.json` and
`.claude-plugin/plugin.json` together, and only for a release.

## Adding a skill

1. Write `skills/<name>/SKILL.md`, `LICENSES/MIT.txt`, `NOTICE.md` and
   `agents/openai.yaml`.
2. Add the skill to `.skill-quality.json`, `skills.sh.json`,
   `.tessl-plugin/plugin.json`, README.md and SECURITY.md.
3. Add eval scenarios under `evals/<name>-<scenario>/`.
4. Run validation and the checks, then commit.

## Publishing to Tessl

The "Publish to Tessl" workflow runs on pushes to `main` that change
`skills/`, `evals/` or `.tessl-plugin/plugin.json`, and publishes only when
the version in `.tessl-plugin/plugin.json` is not in the registry yet and the
`TESSL_TOKEN` repository secret is set. Publishing runs every eval scenario,
which costs Tessl credits, so bump the version only for a release.
Documentation changes never publish. `tessl review run quality skills/<name>`
scores a skill without publishing; keep both at 100.

# Agent Rules <!-- tessl-managed -->

@.tessl/RULES.md follow the [instructions](.tessl/RULES.md)
