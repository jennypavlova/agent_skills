---
name: git-branch-and-pr-workflow
description: "Git branching, committing, pushing, and pull-request mechanics that work in any repository: branch from the right base, small logical commits, no history rewriting on shared branches, keep the branch current, open as draft, link issues. Use when starting a change, committing, pushing, rebasing, or opening/updating a PR."
---

# Git branch and PR workflow

Repo conventions (branch naming, fork vs. direct push, merge strategy, commit format) win over
the defaults below; find them in `CONTRIBUTING.md`, `docs/`, PR templates, or repo skills
(see `repo-orientation`). Repo-specific PR rules live in their own skill (e.g.
`kibana-pr-conventions`).

## 1. Branch

- Fetch first, then branch from the branch you want to merge into (usually `main`);
  for a fix that only exists in a release branch, branch from that release branch.
- One branch per change. Name it `<type>/<short-kebab-description>` (e.g.
  `fix/env-filter-otel-attr`, `feat/service-map-flyout`) unless the repo has its own scheme or
  tooling prescribes a prefix. Lowercase only.
- Fork-based repos (e.g. elastic/kibana): push to your fork, open the PR against upstream.

## 2. Commit

- Small, logical commits; each should build and pass tests on its own. Separate refactors
  from behaviour changes.
- Message: imperative summary line ≤ 72 chars that says what and why, body for context
  when non-obvious. Follow Conventional Commits only if the repo uses them.
- Run the repo's pre-commit checks (lint, format, type check, quick tests) before each
  commit; install the repo's hook if it provides one.
- Use the configured git identity; never commit secrets, local config, or generated noise.

## 3. Push and keep current

- `git push -u origin <branch>` once; plain `git push` afterwards.
- Never force-push or amend commits that others may have pulled or that are under review,
  unless the repo's workflow expects rebases and you own the branch; then use
  `--force-with-lease`, never `--force`.
- Keep the branch current with its base the way the repo prefers: merge upstream (some repos
  offer a bot command, e.g. `@elasticmachine merge upstream`) or rebase. Resolve conflicts
  locally and re-run tests.

## 4. Pull request

- Open as **draft** until CI is green and the description is complete; then mark ready.
- Title: human-readable summary of the change (area prefix if the repo uses one).
- Description: follow the repo's template; always include why, what changed, how it was
  tested, screenshots for UI changes, and `Closes #<n>` for each related issue (see
  `feature-development` § PR description).
- Labels, reviewers, assignee, release-note and backport markers: per the repo's rules.
- Respond to review by pushing new commits (not rewrites) so reviewers can see the delta;
  squash only if the repo's merge strategy does not already do it.

## 5. Before merge / after merge

- All checks green, branch up to date, conversations resolved, approvals per repo policy.
- Merge via the repo's configured strategy (usually in the UI); do not merge your own PR
  where the repo requires review.
- Delete the branch after merge; handle backports if the repo has a flow for them.
