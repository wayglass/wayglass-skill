# wayglass-skill

[![version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fwayglass%2Fwayglass-skill%2Fmain%2F.tessl-plugin%2Fplugin.json&query=%24.version&label=version&prefix=v)](https://tessl.io/registry/wayglass/wayglass)
[![Skill quality](https://github.com/wayglass/wayglass-skill/actions/workflows/skill-quality.yml/badge.svg)](https://github.com/wayglass/wayglass-skill/actions/workflows/skill-quality.yml)
[![skills.sh](https://www.skills.sh/b/wayglass/wayglass-skill?label=skills.sh)](https://www.skills.sh/wayglass/wayglass-skill)
[![tessl](https://img.shields.io/endpoint?url=https%3A%2F%2Fapi.tessl.io%2Fv1%2Fbadges%2Fwayglass%2Fwayglass)](https://tessl.io/registry/wayglass/wayglass)

Skills for AI coding agents that work through
<a href="https://github.com/wayglass/wayglass" target="_blank" rel="noopener noreferrer">Wayglass</a>:
declare an intent before coding, commit with the why, propose under policy,
obey the decision, and review other agents' changes with a reason that says
what was checked.

They complement `wayglass agent setup`, which writes a short block of the
same rules into a repository's `AGENTS.md`. The skills carry the detail that
block leaves out: JSON fields, error codes, overlap re-plans, land failures
and the reviewer's duties. Every command and flag a skill names is checked in
CI against a list generated from the CLI's own `--help` output, so the skills
cannot drift from the tool.

> [!NOTE]
> These are early versions of the skills, written against Wayglass v0.1.0.
> As CI gains more measures of how well each skill works, the results go into
> [SECURITY.md](https://github.com/wayglass/wayglass-skill/blob/main/SECURITY.md)
> alongside the security and quality reports.

## Skills

[SECURITY.md](https://github.com/wayglass/wayglass-skill/blob/main/SECURITY.md)
has the independent security and quality reports.

**[wayglass](https://github.com/wayglass/wayglass-skill/blob/main/skills/wayglass/SKILL.md)**:
the author's loop. `doctor` and per-agent keys for setup, `session show`
after a `session fork`, `intent declare`, why-commits with the
`Wayglass-Intent:` trailer, `push --json` and overlap re-plans,
`propose --json` and exit codes 0, 3 and 4, `land` only when approved,
`sync` to recover, `session share` and `intent abandon`.

**[wayglass-reviewer](https://github.com/wayglass/wayglass-skill/blob/main/skills/wayglass-reviewer/SKILL.md)**:
the reviewer agent's loop. `review --for agent --json`, `wayglass diff`,
checks against the declared goal and paths, and `approve` or `reject` bound
to the decision reviewed, with a real reason, never on its own change and
only across model families when policy asks for it.

The two are separate on purpose: an author never reviews its own work, and a
reviewer never gets a write token for the author's fork.

## Install

Install with Vercel's <a href="https://skills.sh" target="_blank" rel="noopener noreferrer">skills CLI</a>:

```sh
npx skills add wayglass/wayglass-skill
```

> [!NOTE]
> This is the recommended route. One command installs into Claude Code, Codex,
> and dozens of other agents from one shared copy, either per project (committed
> with your code) or for your user. It needs no clone, and `npx skills update`
> pulls new versions later.

It asks which skills and agents to install. Add `--skill wayglass`
(repeatable) to pick skills, `-a claude-code` or `-a codex` to pick an agent,
and `-g` to install for your user instead of the current project. `--list`
shows the skills without installing.

The skills need the `wayglass` CLI on `PATH` and a login to a Wayglass
Worker; `wayglass doctor` checks both. The
<a href="https://github.com/wayglass/wayglass#readme" target="_blank" rel="noopener noreferrer">Wayglass README</a>
covers installing the CLI and running a Worker.

### From a checkout

The skills also load straight from a clone of this repository. Replace
`/path/to/wayglass-skill` with its absolute path.

Claude Code, as a plugin for one session (skills are then named
`/wayglass:wayglass` and `/wayglass:wayglass-reviewer`):

```sh
claude --plugin-dir /path/to/wayglass-skill
```

Claude Code or Codex, as personal skills that stay installed:

```sh
# Claude Code
mkdir -p "$HOME/.claude/skills"
ln -s /path/to/wayglass-skill/skills/* "$HOME/.claude/skills/"

# Codex
mkdir -p "$HOME/.agents/skills"
ln -s /path/to/wayglass-skill/skills/* "$HOME/.agents/skills/"
```

Start a new session afterwards. Symlinked skills follow the checkout, so keep
it in place.

### Pinned in a project

Copy `skills/wayglass` and `skills/wayglass-reviewer` into the project's
`.agents/skills/` (or `.claude/skills/`) and commit them, or let
`npx skills add` do it without `-g`.

## How the skills stay true to the CLI

`scripts/cli-surface.txt` lists every `wayglass` command and the flags it
accepts, generated from `--help` by `scripts/snapshot-cli.sh`.
`scripts/check.sh` fails if a skill names a command or flag that is not in
it. When the CLI changes, build it, regenerate the list, and fix what the
check reports:

```sh
scripts/snapshot-cli.sh /path/to/wayglass
skillforge validate . && skillforge check .
```

`evals/` holds scenarios with weighted checklists for grading an agent that
uses the skills.

## Development

[AGENTS.md](https://github.com/wayglass/wayglass-skill/blob/main/AGENTS.md)
has the editing rules. CI uses
<a href="https://github.com/tpscloud/skillforge-ci" target="_blank" rel="noopener noreferrer">Skillforge</a>;
run `skillforge validate .` and `skillforge check .` before committing.

## License

MIT. See [LICENSE](https://github.com/wayglass/wayglass-skill/blob/main/LICENSE).
Each skill directory carries the same text in `LICENSES/MIT.txt` and a
`NOTICE.md`, so a skill installed on its own keeps its terms. Wayglass is
MIT too, from the same authors; nothing from it is bundled.

Badges are maintained by this project and are not provider endorsements.
[SECURITY.md](https://github.com/wayglass/wayglass-skill/blob/main/SECURITY.md)
explains how to report a security issue.
