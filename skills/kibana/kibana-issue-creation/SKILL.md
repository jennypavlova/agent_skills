---
name: kibana-issue-creation
description: "Create GitHub issues in elastic/kibana for the obs-signals-traces team. Use whenever asked to open, file, or draft a Kibana issue — covers the team label, bug/enhancement label, format conventions, and issue type."
---

# Kibana issue creation (obs-signals-traces team)

When creating a GitHub issue in elastic/kibana for the team:

1. **Team label.** Always apply the `Team:obs-signals-traces` label (obs, not ops). Look up the
   exact spelling on GitHub before use (`gh label list --repo elastic/kibana --search traces`)
   and use that exact string; never type it from memory.

2. **Follow existing conventions.** Before writing, look at similar existing issues in the repo
   (same label, same area) and mirror their title style, section headings, and level of detail.

3. **Labels: `bug` or `enhancement`.** Every issue also gets exactly one of these, by context:
   - `bug` — it is a bug.
   - `enhancement` — small enhancements and any other work.

4. **Issue type field.** Set it only when the context clearly calls for it:
   - `delivery milestone` — the work is something big (a sizeable deliverable).
   - `discovery` — the work is an investigation.
   - `bug` — it is a bug.

   Otherwise do **not** set an issue type unless the caller specifically asks for one.

5. **Team project and status.** Add every issue to the **OBS Signals Traces** project
   <https://github.com/orgs/elastic/projects/1829> (confirm the project name on the page; it is
   private to the org) and set its status to **Backlog** — new issues are not prioritised yet.
   OAPM UI issues go to this same project.

   ```bash
   gh project item-add 1829 --owner elastic --url <issue-url>        # needs the `project` scope
   gh project item-edit --project-id <id> --id <item-id> --field-id <status-field-id> --single-select-option-id <backlog-option-id>
   ```

   Resolve the ids once with `gh project view 1829 --owner elastic --format json` and
   `gh project field-list 1829 --owner elastic`.
