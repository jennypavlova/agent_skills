#!/usr/bin/env bash
# Sync every skill in this repo into the user-level skill directories read by Cursor and
# Claude Code. Run it after cloning and after every `git pull`.
#
# Copies, not symlinks: Cursor's "Sync Skills for Cloud Agents" moves the contents of
# ~/.cursor/skills/ into synced storage, and symlinked skill roots are undocumented, so a
# symlink into this repo could be moved or ignored. A per-skill copy is safe for both tools.
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src_root="$repo_dir/skills"
targets=("$HOME/.cursor/skills" "$HOME/.claude/skills")

count=0
for target in "${targets[@]}"; do
  mkdir -p "$target"
  for skill_md in "$src_root"/*/*/SKILL.md; do
    skill_dir="$(dirname "$skill_md")"
    name="$(basename "$skill_dir")"
    # Replace only this skill's folder, so unrelated skills already in the target survive.
    rm -rf "${target:?}/$name"
    cp -R "$skill_dir" "$target/$name"
    echo "synced  $name  ->  $target/$name/"
    count=$((count + 1))
  done
done

echo
echo "Done: $((count / ${#targets[@]})) skills synced into ${#targets[@]} locations."
echo "Cursor Cloud Agents: enable Settings -> Agents -> 'Sync Skills for Cloud Agents' once."
