---
name: code-review
description: Review a pull request from a PR link. Use when the user runs /code-review or asks for a review of a PR in any repository (work or personal, any language or framework). Covers repo conventions, patterns, performance, language best practices, reuse of existing code, functionality, PR description quality, comment noise, and types.
---

# Code review

Input: a PR link (or branch/diff) from the user. Works in any repo — treat nothing below as
specific to one language, framework, or company.

## 0. Gather context first

- Fetch the PR: title, description, linked issues, diff, and CI status.
- Read the repo's own guidance before judging anything: `README`, `CONTRIBUTING`, `AGENTS.md` /
  `CLAUDE.md`, style guides, lint config (`.eslintrc*`, `.swiftlint.yml`, `pyproject.toml`,
  `.editorconfig`, `prettier`, etc.), PR templates, and CODEOWNERS.
- Skim neighbouring code in the touched areas to learn local idioms.

## 1. Repo conventions are the baseline

Consistency with the repo beats personal preference. Check that the change follows:

- The repo's lint rules and formatter (and does not disable or suppress them without justification).
- Naming, file layout, module boundaries, import style, error-handling style.
- Existing testing conventions (framework, location, naming, what gets mocked).
- Commit / branch / changelog conventions if the repo has them.

Only raise style points the repo itself does not already enforce via tooling.

## 2. Patterns and anti-patterns

- Spot anti-patterns in the diff: duplicated logic, god functions, hidden side effects, swallowed
  errors, magic numbers, deep nesting, premature abstraction, leaky abstractions, mutable shared
  state, inconsistent async handling.
- Check that new code follows the patterns the repo already uses for the same kind of problem
  (state management, data fetching, DI, routing, config, logging).

## 3. Prefer existing components, utilities, and patterns

Generalisation of the "use the existing UI component" rule:

- Before accepting any new component, helper, hook, extension, util, or type, check whether the
  repo (or a package it already depends on) has one that does the job.
- Flag reimplementations of existing functionality, and new dependencies where an existing one
  or the standard library suffices.
- Flag styling or behaviour overrides that reach into another component's internals instead of
  using its public API.
- If something genuinely new is needed, check it lives where similar things live and is reusable
  rather than one-off.

## 4. Performance implications

- Hot paths: unnecessary allocations, N+1 queries, repeated work in loops, missing memoisation
  where the repo uses it, blocking calls on async paths, unbounded collections or inputs.
- UI: unnecessary re-renders, large bundles / imports pulled into the critical path, layout
  thrash, main-thread work that should be off-thread.
- Data: query shape, indexes, pagination, caching, payload size.
- Flag only real or likely impacts; note when something would need measuring rather than guessing.

## 5. Language and framework best practices

Apply the idiomatic rules of whatever the repo uses (TypeScript/React, Swift/SwiftUI, Kotlin,
Python, Go, Rust, ...). Examples of what to look for:

- Type safety: avoid `any`/force-unwraps/unchecked casts; explicit types on public APIs; narrow
  types; exhaustive switches; nullability handled.
- Correct use of the framework's lifecycle and concurrency model (effects/hooks rules, structured
  concurrency, cancellation, main-actor/thread rules).
- Resource and error handling idioms of the language.
- Security basics: input validation, injection, secrets, unsafe deserialisation, auth checks.

## 6. Functionality: does it do what it claims

- Map each claim in the PR description to the code that delivers it; flag gaps and extras.
- Walk the main path and the edge cases: empty, null, error, concurrent, large input, permissions.
- Check tests actually exercise the new behaviour (not just that tests exist), and that no tests
  were weakened, skipped, or deleted to pass.
- Check behavioural changes are reflected in docs, types, migrations, feature flags, i18n, and
  telemetry where the repo has them.

## 7. PR description quality

- Title and description explain the *why*, not just the *what*.
- All requirements / acceptance criteria from the linked issue are addressed or explicitly
  deferred.
- Breaking changes, migrations, rollout steps, screenshots or recordings for UI changes, and
  testing instructions are present when relevant.
- Scope matches the title; unrelated changes are called out or split.

## 8. Comments and noise

- Flag comments that narrate what the code already says, outdated comments, and leftover
  debugging, TODOs without owners, or commented-out code.
- Good comments explain intent, trade-offs, or constraints; ask for those where non-obvious logic
  has none.

## 9. Types and anything the repo signals it cares about

- Types: correctness, no suppressions (`@ts-ignore`, `# type: ignore`, `!` force-unwrap) without
  a local justification, public API types explicit, generated types regenerated.
- Pick up repo-specific signals: accessibility, i18n, bundle size, API compatibility, logging
  format, metrics, docs generation, license headers — whatever the repo's tooling, templates, or
  CI checks show it values.

## Output format

- Lead with a one-paragraph verdict: approve / approve with nits / request changes, and why.
- Then findings grouped by severity: **Blocking**, **Should fix**, **Nit**. Each finding: file and
  line, what is wrong, why it matters, and a concrete suggestion.
- Keep nits brief; do not pad with praise or restate the diff.
- Be explicit about anything you could not verify (e.g. could not run tests locally).
