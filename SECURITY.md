# Security

## Reporting a problem

Report a security issue in these skills, or in the `wayglass` tool they
describe, by email to
[security@tpscloud.services](mailto:security@tpscloud.services) rather than in a
public issue.

## Independent reports

Vercel's [skills.sh](https://skills.sh) runs three security audits on each
published skill, and [Tessl.io](https://tessl.io) reviews each skill's
quality. On 2026-10-14 both skills scored 100/100 in the Tessl quality
review (`tessl review run quality`, reviewer plugin
`tessl/default-skill-review@0.2.0`). The skills.sh audits run once the
repository is listed there, which happens with the first install; those
cells will be filled in when the audits have run. Each result links to that
skill's live report; the README badges link to the same pages.

| Skill | Gen Agent Trust Hub | Socket | Snyk | Tessl quality |
|---|---|---|---|---|
| [wayglass](skills/wayglass/SKILL.md) | [pending](https://www.skills.sh/wayglass/wayglass-skill/wayglass/security/agent-trust-hub) | [pending](https://www.skills.sh/wayglass/wayglass-skill/wayglass/security/socket) | [pending](https://www.skills.sh/wayglass/wayglass-skill/wayglass/security/snyk) | [100/100](https://tessl.io/registry/wayglass/wayglass/quality/wayglass) |
| [wayglass-reviewer](skills/wayglass-reviewer/SKILL.md) | [pending](https://www.skills.sh/wayglass/wayglass-skill/wayglass-reviewer/security/agent-trust-hub) | [pending](https://www.skills.sh/wayglass/wayglass-skill/wayglass-reviewer/security/socket) | [pending](https://www.skills.sh/wayglass/wayglass-skill/wayglass-reviewer/security/snyk) | [100/100](https://tessl.io/registry/wayglass/wayglass/quality/wayglass-reviewer) |

The same day, four pinned static scanners were run on both skills from a
clean export: skilllint 0.3.0 and skilldoctor 0.2.4 (no findings),
NVIDIA SkillSpector 2.12.0 without its model pass (low risk; its only
finding is the "not limited to" wording of the MIT licence text) and
Cisco's AI Skill Scanner 2.2.2 (safe, no findings).

For the whole plugin, Tessl will also publish
[eval results](https://tessl.io/registry/wayglass/wayglass/0.1.0/evals)
and a [security report](https://tessl.io/registry/wayglass/wayglass/0.1.0/security)
for 0.1.0 once it is published to the registry.
