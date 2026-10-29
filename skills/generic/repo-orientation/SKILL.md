---
name: repo-orientation
description: "Get oriented in an unfamiliar or large repository before changing anything: find the agent/contributor guidance, toolchain pins, module layout, build/test/lint entry points, and local conventions. Use at the start of work in a new repo, when asked how a repo is organised, or when unsure where code or tests belong."
---

# Repo orientation

Goal: in a few minutes, know how the repo wants to be worked on, so changes follow its rules
instead of your defaults. Read before editing; do not change anything in this phase.

## 1. Read the guidance files first (in this order)

- `AGENTS.md` / `CLAUDE.md` / `.cursor/rules/` — rules written for agents; they override
  general habits (e.g. Kibana's `AGENTS.md` mandates specific scripts and forbids others).
- `README.md`, `CONTRIBUTING.md`, `docs/` or `dev_docs/` — setup, workflow, review process.
- Repo-level skills: `.cursor/skills/`, `.claude/skills/`, `.agents/skills/` — reuse them;
  do not duplicate them in your own skills.
- `.github/PULL_REQUEST_TEMPLATE.md`, `.github/ISSUE_TEMPLATE*`, `CODEOWNERS` — what PRs and
  issues must contain and who reviews what.

## 2. Toolchain and commands

- Version pins: `.nvmrc` / `.tool-versions` / `.python-version` / `rust-toolchain`,
  `package.json` `engines` and `packageManager`, lockfile type (pnpm/yarn/npm, poetry, cargo).
- Entry points: `package.json` `scripts`, `Makefile`, `justfile`, `scripts/` directory, CI
  workflow files (`.github/workflows`, `.buildkite`) — these reveal the canonical build, test,
  lint, and type-check commands. Prefer the repo's wrapper scripts over calling tools directly.
- Lint and format config: `.eslintrc*`/`eslint.config.*`, `.prettierrc`, `.editorconfig`,
  `pyproject.toml`, `.swiftlint.yml`, etc. Note any pre-commit hook setup.

## 3. Map the structure

- Identify the unit of modularity (packages, plugins, apps, crates) and its manifest (e.g.
  Kibana's `kibana.jsonc` per module with an owner and visibility; `package.json` per
  workspace package; `Cargo.toml` per crate).
- Locate: source vs. tests vs. docs vs. generated code; shared/common code vs. feature code;
  public entry points (`index.ts`, `__init__.py`, `lib.rs`).
- Note ownership and boundaries (CODEOWNERS, "private/shared" visibility, dependency rules)
  — they decide where a change may live.

## 4. Learn local idioms from neighbours

- Open two or three files similar to what you will touch (same kind of component, route,
  service) and copy their structure, naming, error handling, test layout, and import style.
- Check how tests are placed and named next to code (`foo.test.ts`, `test_foo.py`,
  `foo_test.go`) and which helpers/mocks the repo provides.

## 5. Write down what you found

Before coding, summarise in one short block: commands to build/test/lint/type-check, where
your change goes, which conventions apply, and anything the guidance files forbid. Use this as
the checklist for the rest of the task.
