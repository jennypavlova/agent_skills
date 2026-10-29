---
name: kibana-pr-conventions
description: Open and prepare pull requests in elastic/kibana the way the repo expects: PR template sections, release notes, release_note and backport labels, team and version labels, review expectations, and keeping the branch current. Use when creating, describing, labelling, or finalising a Kibana PR, or when asked about Kibana backport or release-note rules.
---

# Kibana PR conventions

Source: `.github/PULL_REQUEST_TEMPLATE.md`,
`docs/extend/contributing/workflow/development-pull-request.md`,
`docs/extend/contributing/workflow/how-we-use-github.md` (labels, release notes, backports),
`docs/extend/contributing/workflow/pr-review.md`, and the repo skill `kbn-github` (gh CLI
usage; opens PRs as draft). Repo docs win if they change; re-check them when in doubt.

## My rules (apply on every Kibana PR)

1. **Always add release notes to the PR.** Fill the Release Notes part of the description with
   a user-facing sentence, and apply the matching `release_note:*` label (see § Labels). Use
   `release_note:skip` only for changes with no user impact, and say why in the description.
2. **Backports.**
   - **Features / enhancements:** usually skip backports — apply `backport:skip`.
   - **Bug fixes:** check which released versions are affected (see the `bug-fix` skill), then
     add `backport:version` **and** a `vX.Y.Z` label for each affected version that should
     receive the fix. The automation backports to the branches matching those version labels
     after merge. If the automatic backport fails, run `node scripts/backport --sha <sha>
     --branch <x.y>` manually.

## 1. Target branch and title

- Target `main` unless the bug exists only in an older branch; if it affects both, say so.
- Title: a human-readable summary of the change, since release notes are generated from it
  ("no 'fixes bug number 123'"). Prefix with the area in brackets when that is the local
  convention (e.g. `[APM] …`, `[Observability] …`) — check recent PRs with the same team label.

## 2. Description (follow `.github/PULL_REQUEST_TEMPLATE.md`)

- **Summary** — what and why, link the issue (`Closes #123`), screenshots or a short recording
  for any visual change.
- **Release note** — see rule 1.
- **Checklist** — tick honestly: EUI writing guidelines and i18n for new text, docs for
  features needing explanation, unit or functional tests for the common scenarios, config-key
  changes allowlisted (cloud, docker list, external injectors; prefer `rename()` over removal),
  breaking HTTP API changes approved and labelled `release_note:breaking`, Flaky Test Runner
  used on changed tests, `release_note:*` and `backport:*` labels applied.
- **Identify risks** — list hard-to-test paths, performance regressions, data-loss potential,
  each with severity and mitigation (`RISK_MATRIX.mdx` has examples). Write "None identified"
  explicitly rather than leaving it empty.

## 3. Labels

| Kind | Labels | Rule |
|---|---|---|
| Team | `Team:…` (e.g. `Team:obs-signals-traces`) | At least one; look up the exact string with `gh label list --repo elastic/kibana --search <term>` (see `kibana-issue-creation`). |
| Release note | `release_note:feature` · `release_note:enhancement` · `release_note:fix` · `release_note:deprecation` · `release_note:breaking` · `release_note:plugin_api_changes` · `release_note:skip` | Exactly one. Deprecations and breaking changes need impact, action, and workaround in the description. |
| Backport | `backport:version` + `vX.Y.Z` labels · `backport:all-open` · `backport:skip` | Per rule 2. `backport` (no suffix) is added by CI after a backport. |
| Version | `vX.Y.Z` | One per version the change ships in (Elastic employees); with `backport:version` these drive the backport targets. |
| Feature | `Feature:…` | Optional, for the feature area. |

## 4. Reviews

- Reviewers are usually auto-assigned by CODEOWNERS; add specific teams or people when the
  change crosses areas.
- Reviewers check the "big three": do we want this change, is it architecturally sound, are
  there sufficient tests (unit for edge cases and errors, plus functional or integration where
  relevant; bug fixes always include a regression test).
- Minimum checklist from `pr-review.md`: CLA and CI green, style guides followed, thorough unit
  coverage, docs where needed, UI changes accessible (contrast, keyboard navigation, aria),
  security considered when rendering API responses, parsing expressions, building URLs,
  loading external content, or redirecting.

## 5. Keeping the PR mergeable

- Branch must be updated with upstream within the last 48 hours to merge. Comment
  `@elasticmachine merge upstream` instead of rebasing locally; it also re-runs CI.
- Open as draft until CI is green and the description is complete (`gh pr create --draft`
  via the `kbn-github` skill), then mark ready for review.
- Before pushing, run the checks from `feature-development` / `bug-fix` and the Kibana type
  check (`kibana-oblt-type-check`).

## Checklist

- [ ] Title summarises the change; issue linked with `Closes #…`
- [ ] Release note written **and** `release_note:*` label applied (rule 1)
- [ ] Backport decision made: `backport:skip` for features, `backport:version` + version labels for bugs (rule 2)
- [ ] Team label present; version labels as required
- [ ] Template checklist and risks section filled honestly
- [ ] Screenshots / recording for UI changes
- [ ] CI green, branch updated with upstream, draft → ready
