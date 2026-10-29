---
name: kibana-pr-conventions
description: Open and finalise pull requests in elastic/kibana: title, description sections (summary, testing, screenshots), labels (Team:obs-signals-traces, release_note, backport, version), assignee, and issue linking. Use when creating, describing, or labelling a Kibana PR, or when asked about Kibana release-note or backport rules.
---

# Kibana PR conventions

Sources: `.github/PULL_REQUEST_TEMPLATE.md`, `docs/extend/contributing/workflow/how-we-use-github.md`,
`docs/extend/contributing/workflow/development-pull-request.md`, and my recent merged PRs
(#299905, #297170, #298342). Repo docs win if they change.

## Rules

1. **Release notes — always.** Write the release-note sentence in the description and apply
   exactly one `release_note:*` label: bug fix → `release_note:fix`; feature → `release_note:feature`
   (brand-new capability) or `release_note:enhancement` (improvement to an existing one); anything
   else keep the repo's default for that kind of change (`release_note:skip` only when there is no
   user impact, and say why).
2. **Backports.** Features: usually skip → `backport:skip`. Bugs: check which released versions
   are affected (see `bug-fix`), then add `backport:version` **plus** a `vX.Y.Z` label for each
   affected version (and the target `main` version). If the auto-backport fails:
   `node scripts/backport --sha <sha> --branch <x.y>`.
3. **Team label: always `Team:obs-signals-traces`.** Apply it to every PR I open, regardless
   of the touched paths. If `.github/CODEOWNERS` lists other teams for those paths, their
   `Team:<name>` labels may be added as extras, but they are optional; the required one is
   always `Team:obs-signals-traces`.
4. **Assign the PR to `jennypavlova`.** Every time.
5. **Link the related issue** whenever one exists: `Closes #<n>` (or the full URL) as the first
   line of the summary. Multiple issues → one `Closes` line each.
6. **UI changes → trigger the team deployment.** When the PR involves UI changes that need
   manual verification (e.g. adding a new button, a new or changed component, flyout, chart,
   layout, copy), add a PR comment after opening the PR with exactly this text and nothing
   else:

   ```text
   /OBLT-deploy
   ```

   This deploys the branch to the team's observability environment so the change can be tested
   manually with real traces data. Use judgment: if the change is not really specific to
   traces/observability and can be verified with normal local data, the comment is optional.
   In most cases with UI changes, add it anyway so a deployment is available for manual testing.
   Skip it for server-only or non-visual changes.

## Title

`[Area] Human-readable summary` — area in brackets as in my PRs (`[APM]`, `[APM][Service map]`,
`[APM][Agent Builder]`). Release notes are generated from the title, so no "fix #123" titles.

## Description (keep the template's order)

- **Summary** — `Closes …` first, then what changed and why, as bullets; for large PRs list the
  commits in review order and what each does.
- **Testing** — how to verify: data setup (e.g. the synthtrace scenario and command), numbered
  manual steps, commands to run (`node scripts/jest …`, type check). Note serverless if
  relevant.
- **Screenshots / recording** — required for any UI change; before/after when it clarifies.
- **Notes for reviewers** — behaviour changes outside the main scope, caps or sampling, known
  gaps that are out of scope (with the issue tracking them).
- **Checklist** and **Identify risks** — from the template; tick honestly and list each risk with
  severity and mitigation. Never leave the risks section empty.

## Labels checklist

| Kind | Label(s) |
|---|---|
| Team | `Team:obs-signals-traces` always; other CODEOWNERS teams optional (rule 3) |
| Release note | one `release_note:*` (rule 1) |
| Backport | `backport:skip` or `backport:version` + `vX.Y.Z` per version (rule 2) |
| Version | `vX.Y.Z` of the `main` release the change ships in |
| CI | `ci:project-deploy-observability` when a serverless deploy is useful for review |

## Before marking ready

- Open as draft (`gh pr create --draft`, see repo skill `kbn-github`); mark ready when CI is
  green and the description is complete.
- Run the checks from `feature-development` / `bug-fix` and `kibana-oblt-type-check` first.
- UI change? Confirm the `/OBLT-deploy` comment was posted (rule 6) and link the deployed
  environment in the testing section if useful.
- Branch older than 48 h vs. upstream cannot merge: comment `@elasticmachine merge upstream`.
