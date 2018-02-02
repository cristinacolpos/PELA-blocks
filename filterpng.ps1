# Unless you are maintaining a git repo of models, you do not need this script
#
# Remove all PNG files from git history to save space before a new build
git filter-branch -f --tree-filter "rm -rf *.png" --prune-empty -- --all