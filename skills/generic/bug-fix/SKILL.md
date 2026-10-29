---
name: bug-fix
description: Workflow for fixing a reported bug in any repository: understand, reproduce, confirm, investigate (what changed last, affected versions, components, data), fix with regression tests, keep existing tests untouched, and open a PR with affected versions, backport handling, and issue linking. Use whenever asked to fix a bug, defect, regression, or incident.
---

# Bug fix

Applies to any repo, language, or framework. Follow the repo's own conventions (and repo-level
skills) wherever they exist; the rules below fill the gaps.

## 1. Understand the issue

Read the bug report, linked discussions, logs, and screenshots. Restate the expected vs. actual
behaviour in one or two sentences before doing anything else.

## 2. Reproduce

- Try to reproduce it yourself (locally, in tests, or against the described environment).
- If the user says they reproduced it, ask for their exact steps and environment so you know them
  and can repeat them.

## 3. Confirm the bug exists before fixing

Establish, with evidence:

- When it happens (conditions, inputs, environment, version).
- What needs doing (the behavioural change expected).

Do not start fixing until the bug is confirmed; if it cannot be confirmed, report that instead.

## 4. Investigate

- **Check what changed last.** If the bug appears between two versions or releases, the change
  between them is usually the cause — bisect commits, releases, or dependency bumps. This is the
  most important step.
- If the bug is long-standing and unrelated to a version release, say so explicitly in the bug
  issue.
- Check the responsible components (for UI bugs, the UI components and their state; otherwise
  the service, module, or function in the path).
- Check the data used: shape, source, and whether there is a reason it changed (schema, upstream
  API, migration, config, feature flag).
- **End with a conclusion:** a clear statement of what the problem is and why it occurs.

## 5. Implement the fix, covered by tests

- Fix the root cause, fully, so it does not recur — not a band-aid on the symptom.
- Add a regression test that fails before the fix and passes after.
- If the bug is a specific edge case, add that edge-case test if it is missing.

## 6. Check tests

- Existing tests must pass before your change and after adding new ones.
- Do not modify existing tests directly to make them pass; that can hide other issues. Add new
  tests instead. If an existing test is genuinely wrong, call it out separately with reasoning.

## 7. Prepare the PR

- If the software is versioned, state the affected versions and the version in which it will be
  fixed. If the target version is unknown, ask the user which version to target.
- Check whether the bug also exists in previous or still-supported versions.
- If the repo has a backporting flow, follow it (labels, branches, tooling). Look for
  repo-level skills or docs on backporting conventions before deciding.
- Link the PR to the right issue so the issue is closed on merge (`Closes #123` or the repo's
  equivalent).
- Follow the repo's PR-opening conventions if documented in repo skills: labels, release notes,
  process requirements. Generic PR-creation guidance (see `feature-development` § PR description)
  covers the rest: concise summary, before/after, testing steps.

## 8. Run tests before pushing

Run the full relevant test suites, type checks, and lint before every push, not only before the
first commit.

## Checklist

- [ ] Expected vs. actual stated
- [ ] Reproduced (or steps obtained from the user)
- [ ] Bug confirmed with evidence
- [ ] Root cause found; last change / version diff checked; conclusion written
- [ ] Fix plus regression / edge-case tests; existing tests untouched and passing
- [ ] Affected and target versions stated; backport handled per repo flow
- [ ] PR linked to the issue; repo PR conventions followed
- [ ] All tests and checks run before pushing
