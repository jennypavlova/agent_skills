---
name: kibana-oblt-type-check
description: Run TypeScript type checks in the elastic/kibana repo using the observability type-check CLI (kbn-ts-type-check-oblt-cli) instead of scripts/type_check. Use whenever asked to type check, verify types, or validate a TypeScript change in Kibana, or before pushing a Kibana PR.
---

# Kibana type check (observability CLI)

In the Kibana repo, **never run `node scripts/type_check`**. Always use the observability CLI:

```bash
node x-pack/solutions/observability/packages/kbn-ts-type-check-oblt-cli/type_check.js
```

It wraps `tsc --build` with GCS-backed artifact caching: a restored cache makes a full check
10-20× faster (1-2 min instead of 20-25 min), and subsequent runs only rebuild projects touched
by local changes. The cache restore is automatic; no flags are needed for the common case.

## When to use

- After any change to `.ts` / `.tsx` files, before committing or pushing.
- As part of the "run all checks" step of `feature-development` and `bug-fix`.
- When a reviewer or CI reports type errors and you need to reproduce them locally.

## Commands

Check a single project (preferred while iterating — pass the project's `tsconfig.json`):

```bash
node x-pack/solutions/observability/packages/kbn-ts-type-check-oblt-cli/type_check.js --project path/to/tsconfig.json
```

Full check of all projects (smart cache restore runs first):

```bash
node x-pack/solutions/observability/packages/kbn-ts-type-check-oblt-cli/type_check.js
```

## Flags

| Flag | Use it when |
|------|-------------|
| `--project <path>` | Limit the check to one `tsconfig.json`. One project per run; run separate commands for multiple projects. |
| `--clean-cache` | You need a guaranteed clean slate: deletes all TypeScript caches and generated `tsconfig.type_check.json` files. |
| `--restore-artifacts` | Only pre-populate the cache from GCS without type checking. `--restore-artifacts=<sha>` restores that exact commit's archive. |
| `--extended-diagnostics` | You need `tsc --extendedDiagnostics` output to debug compiler performance. |
| `--verbose` | You want internal timing breakdowns (download, extraction, scan phases). |

## Behaviour to rely on

- **Progress in non-TTY mode.** When output is piped (CI, agents), progress bars are replaced
  by periodic log lines such as `[TypeCheck] [Full pass] 500 / 1313 projects (38%)`. Keep
  reading new output lines for progress; do not sleep-and-poll.
- **Fail-fast pass.** Without `--project`, the CLI first checks only projects with locally
  modified files (~10-15 s) before the full pass, so the first errors appear quickly.
- **Automatic bootstrap repair.** If `kbn_references` point to unknown projects (e.g. a new
  package on main), the CLI runs `pnpm kbn bootstrap` itself and re-execs. Do not pre-empt it.
- **Log categories.** `[Cache check]` = staleness/restore decision, `[Cache]` = download and
  extraction, `[TypeCheck]` = compiler runs and elapsed time, `[timing]` = verbose-only.
- **State file.** After a successful full run, HEAD is recorded in
  `data/kbn-ts-type-check-oblt-artifacts.sha`; later runs use it to compute staleness.
- **Cache server (optional).** `TS_TYPE_CHECK_CACHE_SERVER_URL` points at a local cache server
  (default `http://127.0.0.1:3081`); set it to an empty string to force GCS. Normally leave it
  alone.

## Interpreting results

- Fix type errors at the root cause. Never suppress with `@ts-ignore`, `@ts-expect-error`, or
  `any`.
- If a project unexpectedly rebuilds hundreds of dependents, a foundational package was
  touched; that is expected and the CLI intentionally skips a pointless cache restore.
- Reference: `x-pack/solutions/observability/packages/kbn-ts-type-check-oblt-cli/README.md`
  (owner: @elastic/observability-ui).
