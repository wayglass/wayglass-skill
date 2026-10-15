# Queue items and the diff

## `wayglass review --for agent --json`

`data.queue` has one item per intent, carrying its latest decision only.
`data.untrusted` names the fields the author or a model wrote;
`data.warnings` and `data.sample` may be present.

`intent`: `id`, `agent`, `family`, `goal`, `reason`, `declared_paths`,
`actual_paths`, `status`, `stale` (no push for 24 hours by default),
`parent` (the intent it is stacked on), `abandoned_reason`.

`decision`: `id` (pass it as `--decision`), `action`, `status`,
`matched_rule`, `reason` (the rule's), `tags` (areas, data classes, risk,
jurisdiction, each with `evidence[].path`), `files`, `commit`,
`approvals_needed`, `approvals` (`by`, `family`, `verdict`, `reason`, `at`,
`identity_source`: `admin`, `key`, `access` or `ai`),
`reviewer_different_family`, `decided_by`, `created_at`,
`intent_status`, `escalation` (an AI reviewer's reason and concerns when it
sent the change to a person; such items leave your queue) and `ai_advice`
(a model's summary, risks and questions written for a person).

Untrusted: `intent.goal`, `intent.reason`, `intent.agent`,
`intent.abandoned_reason`, every path, `tags[].evidence[].path`,
`approvals[].by` and `approvals[].reason`, `escalation.reason` and
`escalation.concerns`, and everything under `ai_advice`.

## `wayglass diff <intent-id> --json`

`data.intent_id`, `data.goal`, `data.reason`, `data.declared_paths`,
`data.files`, `data.base` (the fork base), `data.ref`
(`refs/wayglass/review/<intent-id>`, fetched into this checkout with a
read-only token), `data.diff` (unified diff; `data.truncated` is true past
256 KiB, so read the rest with `git diff <base> <ref> -- <path>`), and
`data.untrusted`: `goal`, `reason`, `files` and `diff`.

`wayglass clone --intent <intent-id> --json` makes a separate read-only
clone of the fork at its pushed head, when a worktree from `data.ref` does
not suit.
