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
