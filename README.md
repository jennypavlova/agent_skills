# agent-skills

Personal agent skills for Cursor and Claude Code. The repo is the source of truth; its skills
are synced into `~/.cursor/skills/` and `~/.claude/skills/` so every agent I use picks them up
(Cursor Desktop and CLI, Claude Code, and Cloud Agents via Cursor's Sync Skills). Everything here
is generic workflow guidance — no business logic, no secrets.

Install:

```bash
git clone https://github.com/jennypavlova/agent_skills.git ~/agent-skills
~/agent-skills/install.sh      # copies each skill into ~/.cursor/skills/ and ~/.claude/skills/
```

Re-run `./install.sh` after every `git pull`. For Cloud Agents, enable Cursor Settings → Agents
→ "Sync Skills for Cloud Agents" once. The script copies rather than symlinks because Cursor's
sync moves the contents of `~/.cursor/skills/` into managed storage.

Layout:

- `skills/generic/`  — workflow skills that apply to any repository (repo orientation, git
  branch and PR workflow, feature development, bug fixing, testing and verification, code
  review, how to write skills)
- `skills/kibana/`   — skills specific to elastic/kibana (issue creation, PR conventions, type
  checking)

Each skill is a folder with a `SKILL.md`. The frontmatter `name` must equal the folder name and
`description` states what the skill does and when to use it. See
`skills/generic/skill-creation/` for the conventions.

Note on `kibana-oblt-type-check`: no existing `SKILL.md` for the observability type-check CLI
exists in the Kibana checkout. The skill is written from my Cursor user rule ("always use
`x-pack/solutions/observability/packages/kbn-ts-type-check-oblt-cli/type_check.js`") and that
package's `README.md`.
