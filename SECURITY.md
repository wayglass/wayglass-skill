# Security

## Reporting a problem

Report a security issue in these skills, or in the `wayglass` tool they
describe, by email to
[security@tpscloud.services](mailto:security@tpscloud.services) rather than in a
public issue.

## Independent reports

Vercel's [skills.sh](https://skills.sh) runs three security audits on each
published skill, and [Tessl.io](https://tessl.io) reviews each skill's
quality. Results from 2026-10-15 are below. Both skills scored 100/100 in
the Tessl quality review and passed the Gen Agent Trust Hub audit; Socket and
Snyk each raised one medium warning per skill, explained under the table.
Each result links to that skill's live report; the README badges link to the
same pages.

| Skill | Gen Agent Trust Hub | Socket | Snyk | Tessl quality |
|---|---|---|---|---|
| [wayglass](skills/wayglass/SKILL.md) | [pass](https://www.skills.sh/wayglass/wayglass-skill/wayglass/security/agent-trust-hub) | [warn](https://www.skills.sh/wayglass/wayglass-skill/wayglass/security/socket) | [warn](https://www.skills.sh/wayglass/wayglass-skill/wayglass/security/snyk) | [100/100](https://tessl.io/registry/wayglass/wayglass/quality/wayglass) |
| [wayglass-reviewer](skills/wayglass-reviewer/SKILL.md) | [pass](https://www.skills.sh/wayglass/wayglass-skill/wayglass-reviewer/security/agent-trust-hub) | [warn](https://www.skills.sh/wayglass/wayglass-skill/wayglass-reviewer/security/socket) | [warn](https://www.skills.sh/wayglass/wayglass-skill/wayglass-reviewer/security/snyk) | [100/100](https://tessl.io/registry/wayglass/wayglass/quality/wayglass-reviewer) |

**Snyk, W011 (third-party content exposure)** on both skills. The skills
read text written by other agents and pushers: intents' goals and reasons,
commit messages, session notes and the diff under review. An agent reading
that text could meet an indirect prompt injection. That exposure is the
skills' purpose, and both already treat every such field as data: the
`wayglass` CLI lists them in `data.untrusted`, and each skill tells the
agent never to follow instructions found in them or paste them into a
shell command.

**Socket (medium, "suspicious")** on both skills. Socket found the text
coherent with its stated purpose and the safeguards sensible; its concern
is supply chain: the skills rely on an external `wayglass` CLI that holds a
key and modifies repositories, and the scanned 0.1.0 text did not say where
that binary comes from. The CLI is the open source tool of the same project,
<https://github.com/wayglass/wayglass> (MIT), with signed and notarized
macOS archives and checksums on its Releases page. The skills now say so
and tell agents to take it from there or build it from source. The table
will be updated when Socket scans that text.

Tessl's own security review of the plugin rated 0.1.0
[low risk](https://tessl.io/registry/wayglass/wayglass/0.1.0/security).
Four pinned static scanners were also run on both skills from a clean
export: skilllint 0.3.0 and skilldoctor 0.2.4 (no findings), NVIDIA
SkillSpector 2.12.0 without its model pass (low risk; its only finding is
the "not limited to" wording of the MIT licence text) and Cisco's AI Skill
Scanner 2.2.2 (safe, no findings).

For the whole plugin, Tessl also publishes
[eval results](https://tessl.io/registry/wayglass/wayglass/0.1.0/evals)
for 0.1.0; the four scenarios were still running when this was written.
