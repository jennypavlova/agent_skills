---
name: skill-creation
description: How to create or update a skill in this skills folder (SKILL.md files synced to Cursor and Claude). Use whenever asked to add a new skill, turn dictated rules or a user rule into a skill, scaffold a skill placeholder, or review a skill for completeness.
---

# Skill creation

A skill is a folder containing a `SKILL.md` that an agent loads on demand. This meta skill
captures the conventions used by the skills in this folder so new ones look and behave the same.

## 1. Folder layout

```text
skills/
├── generic/<skill-name>/SKILL.md   # applies to any repo, language, or framework
└── kibana/<skill-name>/SKILL.md    # specific to elastic/kibana (or another <repo>/ section)
```

- One folder per skill. The folder name **is** the skill identity and must equal the frontmatter
  `name`: lowercase letters, digits, and hyphens only (e.g. `bug-fix`, `kibana-issue-creation`).
- Repo-specific skills carry the repo as a prefix (`kibana-…`); generic skills do not.
- Optional subfolders: `scripts/` (runnable helpers), `references/` (long material loaded on
  demand), `assets/` (templates, data). Keep `SKILL.md` itself focused.

## 2. SKILL.md structure

```markdown
---
name: <folder-name>
description: <what it does> + <when to use it, phrased with the words a user would say>
---

# <Title>

<One or two lines of scope: what it applies to, and that repo conventions win over these rules.>

## 1. <First step or topic>
...
## N. <Last step or topic>

## Output format / Checklist   (optional)
```

- **Frontmatter**: only `name` and `description` (both required). These are the fields Cursor
  and Claude both understand; avoid tool-specific keys so the file stays portable.
- **Description** is what the agent uses to decide relevance. Include the action ("review a PR",
  "fix a bug", "create a GitHub issue"), the trigger phrases (`/code-review`, "implement a
  feature"), and the scope ("any repository", "elastic/kibana"). Keep it to one or two
  sentences.
- **Body**: numbered sections in the order the work is actually done (understand → plan →
  implement → verify → PR). Use short bullets, bold the key noun of each bullet when a section
  has many, and end with a checklist or output-format section when the skill drives a
  multi-step task.

## 3. What a good skill contains

- **Trigger conditions** in the description and, if needed, a first line in the body
  ("Input: a PR link…").
- **Ordered steps** — what to do first, next, last. Mark the most important step explicitly
  when one exists ("This is the most important step").
- **Constraints and prohibitions stated explicitly**, in the user's words: "do not modify
  existing tests", "never as a separate review", "never guess the label".
- **References to repo-specific conventions to look up**, not hardcoded values: "look for
  repo-level skills on backporting", "run `gh label list` and use the exact string". Where a
  concrete value is useful today, give it as a hint with "re-verify before use".
- **Cross-references** to sibling skills instead of duplicating them (`see the code-review
  skill`, `see feature-development § PR description`).
- **Checklists** at the end for workflows with many gates; **output format** for skills that
  produce a report.
- Scope statement that the repo's own conventions take precedence over the skill.

## 4. Where to look when creating a skill

1. **Existing skills in this folder** — copy their structure and tone; `code-review`,
   `feature-development`, `bug-fix`, and `kibana-issue-creation` are the reference examples.
2. **The target repo** — its own skills (`.cursor/skills/`, `.claude/skills/`,
   `.agents/skills/`), `README`, `CONTRIBUTING`, `AGENTS.md` / `CLAUDE.md`, lint and test
   configs, PR and issue templates, CI checks. Repo-specific rules belong in the repo-section
   skill, phrased as "look up X in the repo" where the value may change.
3. **Material the caller already has** — prior chat context, dictated rules, and existing
   user rules (e.g. a user rule mandating a specific CLI becomes the body of a `kibana-…`
   skill). Reuse it verbatim where possible rather than re-deriving it.
4. **External sources** (CLI READMEs, tool docs) only to fill in exact commands and flags.

## 5. Checks before finishing a skill

- Every dictated rule is captured; walk the caller's list item by item against the file.
- Prohibitions are preserved exactly, not softened ("do not change existing tests", "never as a
  separate review", "never guess").
- No invented rules: anything not dictated or clearly implied by the repo is left out or marked
  as a hint to verify.
- `name` equals the folder name; `description` names the action, trigger, and scope.
- Wording is repo-agnostic in `generic/`, and repo values in `kibana/` are look-ups or
  "re-verify" hints.
- Placeholders (`TODO`) only when content is genuinely pending; a placeholder keeps the
  frontmatter valid so the folder still parses.
- Nothing is committed, linked, or installed as part of writing the skill unless explicitly
  asked.

## 6. Minimal placeholder

Use this when scaffolding a skill whose content the caller will dictate later:

```markdown
---
name: <folder-name>
description: TODO — what this skill does and when the agent should use it.
---

# <folder-name>

TODO
```
