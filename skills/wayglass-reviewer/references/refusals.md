# Refusals from approve and reject

Every refusal is one envelope with `ok: false`; nothing was recorded.

| Exit | `error.code` | Meaning and what to do |
|---|---|---|
| 2 | `usage` | Missing, placeholder or filler reason, or an unknown `--family`. Write what you checked. |
| 1 | `conflict` | You wrote this change, it was already decided, the intent is no longer active, or it has nothing proposed. Do not retry. |
| 1 | `decision_replaced` | The author proposed again after the decision you named with `--decision`. List the queue again and review the new decision; the old one no longer counts. |
| 4 | `needs_human` | Policy routed this change to a person. Leave it and tell your user. |
| 1 | `superseded` | The intent was re-stacked after it was proposed; that decision no longer counts. Skip it until the author proposes again. |
| 1 | `same_family` | Policy needs a reviewer from a family other than the author's. Leave it. |
| 1 | `family_required` | You or the author declared no family. Set `WAYGLASS_AGENT_FAMILY` to your real family; if the author declared none, leave it. |
| 1 | `not_found` | Wrong intent id or project. |
| 1 | `bad_request` | The reason holds control characters. Write plain text. |
| 1 | `unauthorized` | The key was refused. Run `wayglass doctor --json`. |

The Worker checks in this order: superseded, then not pending, then
`decision_replaced`, then `needs_human`, then an inactive intent, then the
author deciding its own change, then the family rules (approvals only).
A rejection passes the family rules.

The Worker's own AI reviewer, when a project runs one, decides
`agent_review` changes whose rule does not name `reviewer: agent`. It
approves as `<provider>:<model>` or escalates to a person (the decision
becomes `pending_human` with `detail.escalation`); it never rejects, and
it refuses rules that name `reviewer: agent` (`needs_agent`). Items it has
taken are no longer in your queue.

## Source

Written against the `wayglass` CLI help and source at release v0.1.0
(commit `358f72c`): `review`, `diff`, `approve` and `reject` in
`internal/cli/`, and the Worker's decide checks in `worker/src/`. The
skill's repository checks every command and flag named in the skill against
a list generated from that release's `--help` output.
