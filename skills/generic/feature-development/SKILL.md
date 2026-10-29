---
name: feature-development
description: End-to-end workflow for implementing a feature in any repository: plan first, type-safe implementation, unit/integration/e2e tests per repo convention, run all checks, internal self-review folded into the feature commits, and a concise PR description. Use whenever asked to implement, build, or add a feature or sizeable change.
---

# Feature development

Applies to any repo, language, or framework. Follow the repo's own conventions wherever they
exist; the rules below fill the gaps.

## 1. Plan first

Before writing code, produce a short plan and keep it updated. It must cover:

- **Implementation** — what changes where, how the issues or constraints faced will be addressed,
  and which existing code is reused.
- **UX improvements** — what gets better for the user, not just what gets added.
- **UX requirements**
  - Components consistent with the repo's existing ones (reuse before creating).
  - Every interactive element is actually clickable / tappable with a sensible hit target.
  - Accessibility labels on all interactive and informative elements.
  - Fully keyboard navigable with a visible focus order.
- **Performance** — expected cost of the change and how it is kept small (rendering, queries,
  network, memory).
- **Quality** — no repetition, no side tracks or unrelated refactors; code is simple, reusable,
  readable, and maintainable.

## 2. Types and linting

- Everything is typed: no `any` / untyped escapes, explicit types on public APIs, no type
  suppressions without a local justification.
- Follow the repo's linter and formatter (ESLint, SwiftLint, ruff, golangci-lint, clippy, ...);
  fix root causes instead of disabling rules.

## 3. Testing

Order of work:

1. **Unit tests first.** Keep them concise. Go beyond the happy path: wrong types or shapes, very
   large numbers, zeros, negatives, empty and null inputs, boundary values.
2. **Integration tests** if the project has them.
3. **End-to-end or other test kinds** according to the repo's convention (e.g. Playwright/Scout
   UI tests, API tests, deployment-agnostic suites).

Rules:

- Follow the repo's existing testing practices: framework, file location, naming, mocking style.
- Add tests only with what is already in the repo; do not introduce new test frameworks or
  runners.
- Never weaken, skip, or delete tests to make them pass.

## 4. Run all checks before committing

Run everything the repo offers — tests, type check, lint, formatting, and all pre-commit hooks —
and make them pass before each commit. Commit in logical units.

## 5. Internal review of your own work

Do this on every feature, before opening or updating the PR:

- Review the feature and the tests as a reviewer would (see the `code-review` skill): does it do
  what it claims, edge cases, reuse, performance, readability.
- Run the tests, type checks, repo-specific checks, and any additional checks relevant to the
  change.
- Address findings by amending the existing commits or adding a refactoring commit. Never present
  this as a separate review step or PR comment — it is internal and part of the feature.

## 6. PR description

Concise and readable by a non-author. Not a wall of text.

Structure:

1. **Summary** — a few sentences on what and why, with the linked / closed issue
   (`Closes #123`).
2. **Before / after** — screenshots or a short recording for UI changes; a comparison table when
   it clarifies behaviour, performance, or output differences.
3. **Testing** — exact commands to run (e.g. `node scripts/jest path/to/test`), plus manual setup
   and verification steps.
4. Optional simple bullet sections: **Next steps**, **Follow-up issues**, **Notes for reviewers**.
