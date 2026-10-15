#!/bin/sh
# Repository checks. Skillforge validates frontmatter; this checks the prose.
#
# 1. Every `wayglass ...` command in a skill (shell fences and inline code)
#    names a real command and only flags that command accepts, according to
#    scripts/cli-surface.txt (regenerate it with scripts/snapshot-cli.sh).
# 2. No em or en dashes in Markdown.
# 3. Every relative Markdown link in a skill points at a file that exists.
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
surface="$root/scripts/cli-surface.txt"
fail=0

if [ ! -s "$surface" ]; then
  echo "error: $surface is missing; run scripts/snapshot-cli.sh with a wayglass binary" >&2
  exit 1
fi

echo "== checking wayglass commands against scripts/cli-surface.txt"
for f in "$root"/skills/*/SKILL.md "$root"/skills/*/references/*.md; do
  [ -f "$f" ] || continue
  awk -v surface="$surface" -v rel="${f#"$root"/}" '
    BEGIN {
      FS = "\n"
      while ((getline line < surface) > 0) {
        if (line ~ /^#/) continue
        split(line, parts, "\t")
        known[parts[1]] = 1
        nf = split(parts[2], fl, " ")
        for (i = 1; i <= nf; i++) flag[parts[1], fl[i]] = 1
        # Mark every parent of this path as a command group.
        p = parts[1]
        while (match(p, / [^ ]+$/)) { p = substr(p, 1, RSTART - 1); group[p] = 1 }
      }
      close(surface)
    }
    function check(cmd, where,    n, w, i, path, t) {
      gsub(/"[^"]*"/, "ARG", cmd)
      gsub(/\047[^\047]*\047/, "ARG", cmd)
      sub(/[ \t]#.*$/, "", cmd)
      sub(/[|;&>].*$/, "", cmd)
      n = split(cmd, w, " ")
      path = w[1]
      for (i = 2; i <= n; i++) {
        if ((path " " w[i]) in known) path = path " " w[i]
        else break
      }
      if (path in group && i <= n && w[i] ~ /^[a-z]/) {
        printf "%s:%d: \"%s %s\" is not a wayglass command\n", rel, where, path, w[i]; bad = 1
        return
      }
      for (; i <= n; i++) {
        t = w[i]
        if (t !~ /^-/) continue
        sub(/=.*$/, "", t)
        if (!((path, t) in flag)) {
          printf "%s:%d: \"%s\" does not take %s\n", rel, where, path, t; bad = 1
        }
      }
    }
    /^[ \t]*```/ {
      if (fence) { fence = 0 } else { fence = 1; shell = ($0 ~ /```(sh|bash|shell)[ \t]*$/) }
      next
    }
    fence && shell {
      line = $0
      if (pending != "") { line = pending " " line; pending = "" }
      if (line ~ /\\[ \t]*$/) { sub(/\\[ \t]*$/, "", line); pending = line; next }
      sub(/^[ \t]*(\$ )?/, "", line)
      if (line ~ /^wayglass /) check(line, NR)
      next
    }
    !fence {
      line = $0
      while (match(line, /`wayglass [^`]*`/)) {
        check(substr(line, RSTART + 1, RLENGTH - 2), NR)
        line = substr(line, RSTART + RLENGTH)
      }
    }
    END { exit bad }
  ' "$f" || fail=1
done

echo "== sweeping Markdown for em and en dashes"
if grep -rn --include='*.md' --exclude-dir=.git --exclude-dir=.skill-quality \
  -e "$(printf '\342\200\224')" -e "$(printf '\342\200\223')" "$root"; then
  echo "error: em or en dash in the files listed above" >&2
  fail=1
fi

echo "== checking relative links in skills"
for f in "$root"/skills/*/SKILL.md "$root"/skills/*/references/*.md; do
  [ -f "$f" ] || continue
  dir=$(dirname "$f")
  for target in $(grep -o '](\([^)#:]*\)[)#]' "$f" | sed 's/^](//; s/[)#]$//' | sort -u); do
    [ -n "$target" ] || continue
    if [ ! -e "$dir/$target" ]; then
      echo "${f#"$root"/}: broken link $target"
      fail=1
    fi
  done
done

if [ "$fail" -ne 0 ]; then
  echo "Repository checks failed. Fix the reported errors and rerun skillforge check ." >&2
  exit 1
fi
echo "All repository checks passed."
