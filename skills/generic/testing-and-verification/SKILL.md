---
name: testing-and-verification
description: "How to verify a change in any repository: discover the repo's test layers and commands, pick the right layer, write tests the repo's way, run lint, type check and tests at the right scope, and prove the change works before pushing. Use when asked to test, verify, validate, or run checks on a change, or when deciding which kind of test to add."
---

# Testing and verification

Repo conventions win: find the canonical commands in `AGENTS.md`, `CONTRIBUTING.md`,
`package.json` scripts, `Makefile`, CI config, and repo skills (see `repo-orientation`).
Never introduce a new test framework or runner.

## 1. Discover the layers the repo has

Typical ladder, cheapest first; use whatever subset exists:

1. **Static**: formatter, linter, type checker (e.g. `node scripts/eslint`, `ruff`, `tsc`,
   `cargo clippy`). Some repos bundle them: Kibana's `node scripts/check.js --scope=local|staged|branch`.
2. **Unit**: fast, isolated, mocked deps (`jest`, `pytest`, `go test`, `XCTest`).
3. **Integration**: real dependencies in-process or in containers (DB, HTTP server).
4. **End-to-end / UI / API**: against a running system (Playwright, Scout, Cypress, FTR).
5. **Manual verification**: for visual changes, a deployed or local instance plus screenshots.

Write down the exact command and config-discovery rule for each layer (e.g. "Jest config is
auto-discovered from the test path; one `--config` per run").

## 2. Pick the layer for the change

- Logic, parsing, formatting, reducers, helpers → unit.
- Anything touching storage, network, or another service's contract → integration.
- User-visible flows, navigation, rendering across components → e2e/UI; keep few and stable.
- Bug fix → a regression test at the lowest layer that reproduces it.
- Public HTTP API → test observable behaviour (status, body, errors), not internals.

## 3. Write tests the repo's way

- Co-locate and name like neighbours (`foo.test.ts`, `test_foo.py`, `foo_test.go`).
- Reuse the repo's mocks, fixtures, factories, and render helpers instead of hand-rolled ones.
- Cover edge cases beyond the happy path: empty, null, wrong type, zero, negative, very large,
  boundaries, errors/rejections, concurrency where relevant.
- One behaviour per test, clear names, no logic in tests, minimal snapshots.
- Never skip, delete, or loosen existing tests to go green; fix the code or justify the test
  change separately.

## 4. Run at the right scope, in order

1. Static checks on changed files.
2. Unit tests for the touched modules (the file or its package config).
3. Integration/e2e suites that cover the touched area.
4. Type check at package scope (whole-repo only when shared types changed).
5. Repeat the full set once more right before pushing; a passing run earlier does not count.

For flaky suspicion: run the file several times; use the repo's flaky-test tooling if any.

## 5. Prove it

- Record what you ran and the result (command + pass/fail) in the PR's Testing section.
- For UI changes: before/after screenshots or a short recording from the real app.
- For performance claims: a measurement, not a guess.
- State explicitly anything you could not verify and why.
