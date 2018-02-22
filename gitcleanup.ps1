# Remove all PNG and STL files from git history to save space before a new build
#
# Unless you are maintaining a git repo of models, you do not need this script

git filter-branch -f --tree-filter "rm -rf *.png && rm -rf *.stl" --prune-empty -- --all

# Finish removing dead space from the git repo after filtering out media files
# Run this _after_ filterstl.ps1 and filterpng.ps1
Write-Output "git reflog expire --expire=now --all"
git reflog expire --expire=now --all

Write-Output "git gc --aggressive --prune=now"
git gc --aggressive --prune=now

Invoke-Expression ".\make.ps1 -clean -png"

Write-Output "================================"
Write-Output "Now type: git push --all --force"
Write-Output "       (if no changes since this process started)"
