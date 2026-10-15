# TODO

- [ ] Record the skills.sh audits. The repository is not on
  <https://www.skills.sh/wayglass/wayglass-skill> until the first
  `npx skills add wayglass/wayglass-skill` install is counted; once the
  three audits (Gen Agent Trust Hub, Socket, Snyk) have run, fill the cells
  in the SECURITY.md table and remove the sentence saying they are pending.
- [ ] Publish 0.1.0 to Tessl. The "Publish to Tessl" workflow needs the
  `TESSL_TOKEN` repository secret; publishing runs the four eval scenarios,
  which cost credits, so set the secret only when ready. The registry pages
  the badges and SECURITY.md link to are 404 until then.
- [ ] Run a live agent through both skills on a `demo-test-*` project and
  record what it got wrong; the evals have not been run against a real
  Worker yet.
- [ ] Add skill metrics to CI, as the README promises: the skills.sh audits,
  the Tessl quality reviews and the eval results per release, so SECURITY.md
  and the badges come from CI output rather than hand edits.
