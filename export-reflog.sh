#!/bin/sh

echo "=== Exporting reflog evidence ==="

mkdir -p reflog
NOW=$(date -u "+%Y-%m-%d %H:%M:%S UTC")

# HEAD
(
echo "Evidence: Part 9 – Repository Activity"
echo "Scope: HEAD movements"
echo "Generated: $NOW"
echo "----------------------------------------"
git reflog
) > reflog/reflog_HEAD.txt

# branches
for branch in $(git for-each-ref --format='%(refname:short)' refs/heads/)
do
    safe_name=$(echo "$branch" | tr '/' '_')

    (
    echo "Evidence: Branch activity log"
    echo "Branch: $branch"
    echo "Generated: $NOW"
    echo "----------------------------------------"
    git reflog show "$branch"
    ) > "reflog/reflog_${safe_name}.txt"
done

echo "Done."


# -------------------------
# evidence index file
# -------------------------
echo "Creating reflog index..."

(
echo "# Reflog Evidence"
echo ""
echo "Generated: $NOW"
echo ""
echo "This directory contains repository activity logs."
echo ""
echo "Files:"
ls reflog | sed 's/^/- /'
) > reflog/README.md


echo "=== Reflog export completed ==="
echo "Files saved in ./reflog/"
echo ""
echo "Next step:"
echo "  git add reflog/"
echo "  git commit -m \"Evidence: Add reflog records\""
echo "  git push"
