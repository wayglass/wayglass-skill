# wayglass-skill

Skills that teach coding agents (Claude Code, Codex and others) to work
through [Wayglass](https://github.com/wayglass/wayglass): declare an intent
before coding, commit with the why, propose under policy, obey the decision,
and review other agents' changes with a reason that says what was checked.

They complement `wayglass agent setup`, which writes a short block of the same
rules into a repository's `AGENTS.md`. The skills carry the detail that block
leaves out: JSON fields, error codes, overlap re-plans and land failures.

## Skills

**[wayglass](skills/wayglass/SKILL.md)**: the author's loop. `doctor` and
per-agent keys for setup, `session show` after a `session fork`,
`intent declare`, why-commits with the `Wayglass-Intent:` trailer,
`push --json` and overlap re-plans, `propose --json` and exit codes 0, 3 and
4, `land` only when approved, `session share` and `intent abandon`.

**[wayglass-reviewer](skills/wayglass-reviewer/SKILL.md)**: the reviewer
agent's loop. `review --for agent --json`, `wayglass diff`, checks against the
declared goal and paths, and `approve` or `reject` with a real reason, never
on its own change and only across model families when policy asks for it.

## Install

With Vercel's [skills CLI](https://skills.sh) (needs the repository to be
public):

```sh
npx skills add wayglass/wayglass-skill
```

From a checkout, replacing `/path/to/wayglass-skill` with its absolute path:

```sh
# Claude Code, for one session (skills are then /wayglass:wayglass and so on)
claude --plugin-dir /path/to/wayglass-skill

# Claude Code, installed for your user
mkdir -p "$HOME/.claude/skills"
ln -s /path/to/wayglass-skill/skills/* "$HOME/.claude/skills/"

# Codex
mkdir -p "$HOME/.agents/skills"
ln -s /path/to/wayglass-skill/skills/* "$HOME/.agents/skills/"
```

To pin them in a project, copy `skills/wayglass` and
`skills/wayglass-reviewer` into its `.agents/skills/` (or `.claude/skills/`)
and commit them. Start a new agent session afterwards.

The skills need the `wayglass` CLI on `PATH` and a login to a Wayglass
Worker; `wayglass doctor` checks both.

## How the skills stay true to the CLI

`scripts/cli-surface.txt` lists every `wayglass` command and the flags it
accepts, generated from `--help` by `scripts/snapshot-cli.sh`.
`scripts/check.sh` fails if a skill names a command or flag that is not in
it. When the CLI changes, rebuild it, regenerate the list, and fix what the
check reports:

```sh
scripts/snapshot-cli.sh /path/to/wayglass
skillforge validate . && skillforge check .
```

`evals/` holds scenarios with weighted checklists for grading an agent that
uses the skills.

## License

MIT. See [LICENSE](LICENSE). Each skill directory carries the same text in
`LICENSES/MIT.txt` and a `NOTICE.md`, so a skill installed on its own keeps
its terms.
