# agent-skills (scaffold, not yet a git repo)

Personal agent skills to be synced later into `~/.cursor/skills/` and `~/.claude/skills/`.
Nothing here is linked, committed, or installed yet.

Layout:

- `skills/generic/`  — workflow skills that apply to any repository
- `skills/kibana/`   — skills specific to elastic/kibana

Each skill is a folder with a `SKILL.md`. The frontmatter `name` must equal the folder name.
All files are placeholders (`TODO`) awaiting real content.

Note on the type-check skill: no existing SKILL.md for the oblt type-check CLI was found in the
Kibana checkout. The source material is the Cursor user rule ("always use
`x-pack/solutions/observability/packages/kbn-ts-type-check-oblt-cli/type_check.js`") and that
package's `README.md`. `skills/kibana/kibana-oblt-type-check/` is the placeholder for it.
