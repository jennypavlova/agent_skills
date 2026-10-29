---
name: kibana-issue-creation
description: Create GitHub issues in elastic/kibana for the opsignal traces team. Use whenever asked to open, file, or draft a Kibana issue — covers the team label, format conventions, issue type, and the enhancement label.
---

# Kibana issue creation (opsignal traces team)

When creating a GitHub issue in elastic/kibana for the team:

1. **Team label.** Always apply the "opsignal traces" team label. Look up its exact spelling on
   GitHub (e.g. `gh label list --repo elastic/kibana --search traces`) and use that exact string.
   Never guess or type it from memory. At the time of writing it resolves to
   `Team:obs-signals-traces`; re-verify before use.

2. **Follow existing conventions.** Before writing, look at similar existing issues in the repo
   (same label, same area) and mirror their title style, section headings, and level of detail.

3. **Issue type by context:**
   - `delivery milestone` — the work is something big (a sizeable deliverable).
   - `discovery` — the work is an investigation.
   - `bug` — it is a bug.

4. **Everything else** (small enhancements, anything not covered above): keep it simple. Apply the
   `enhancement` label and do **not** set an issue type unless the caller explicitly asks for one.
