# agent-skills

Personal agent skills for Cursor and Claude Code. The repo is the source of truth; its skills
are synced into `~/.cursor/skills/` and `~/.claude/skills/` so every agent I use picks them up
(Cursor Desktop and CLI, Claude Code, and Cloud Agents via Cursor's Sync Skills). Everything here
is generic workflow guidance — no business logic, no secrets.

## Setup

1. Clone the repo:

   ```bash
   git clone https://github.com/jennypavlova/agent_skills.git ~/projects/agent-skills
   ```

2. Copy the skills into the user-level skill directories:

   ```bash
   ~/projects/agent-skills/install.sh
   ```

   This copies each skill folder into `~/.cursor/skills/<name>/` and `~/.claude/skills/<name>/`
   and prints what it did. Skills already in those directories that are not from this repo are
   left alone.

3. Make the skills available to Cloud Agents (once): in Cursor Desktop open
   **Settings → Agents**, and under **Context and Tools** turn on **Sync Skills for Cloud Agents**,
   then confirm. Cursor reports the synced count (10/10 for this repo) and keeps uploading changes
   while it is running.

4. Verify: start a **new** Cloud Agent session (running agents do not pick up newly synced
   skills). The skills appear in the agent's skill list grouped under the personal/user group
   that points at `~/.cursor/skills`.

After every `git pull`, re-run `./install.sh`; Cursor syncs the updated copies automatically.

Why copies and not symlinks: Cursor's sync moves the contents of `~/.cursor/skills/` into managed
storage, and symlinked skill roots are undocumented, so a symlink into this clone could be moved
or ignored. A per-skill copy is safe for both Cursor and Claude Code.

## Layout

- `skills/generic/` — workflow skills that apply to any repository: `repo-orientation`,
  `git-branch-and-pr-workflow`, `feature-development`, `bug-fix`, `testing-and-verification`,
  `code-review`, `skill-creation`
- `skills/kibana/` — skills specific to elastic/kibana: `kibana-issue-creation`,
  `kibana-pr-conventions`, `kibana-oblt-type-check`

Each skill is a folder with a `SKILL.md`. The frontmatter `name` must equal the folder name and
`description` states what the skill does and when to use it. See
`skills/generic/skill-creation/` for the conventions.

Note on `kibana-oblt-type-check`: no existing `SKILL.md` for the observability type-check CLI
exists in the Kibana checkout. The skill is written from my Cursor user rule ("always use
`x-pack/solutions/observability/packages/kbn-ts-type-check-oblt-cli/type_check.js`") and that
package's `README.md`.
