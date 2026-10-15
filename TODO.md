# TODO

- [ ] Record the 0.1.0 eval results. The Tessl eval run for
  `wayglass/wayglass@0.1.0` (four scenarios) was in progress when
  SECURITY.md was last written; the overview showed an aggregate of 85 and
  0.66x before the per-scenario data appeared. Read `tessl eval view` for
  the run, note which scenarios the baseline solved on its own (see what
  charmedimsure learned about baseline strength), and either tighten those
  scenarios or record the result as is in SECURITY.md.
- [ ] Record the Socket re-scan. The 0.1.0 scan did not see the sentence on
  where the `wayglass` CLI comes from (added after publish). Once the Socket
  pages show a later analysis date than Oct 15, 2026, 03:49 AM UTC, update
  the two Socket cells and remove the sentence saying the table will be
  updated. The Snyk W011 warning is inherent to the skills' purpose and
  stays documented, as flared's is.
- [ ] Run a live agent through both skills on a `demo-test-*` project and
  record what it got wrong; task 043 in the private meta repo does this
  with the published skills installed.
- [ ] Add skill metrics to CI, as the README promises: the skills.sh audits,
  the Tessl quality reviews and the eval results per release, so SECURITY.md
  and the badges come from CI output rather than hand edits.
