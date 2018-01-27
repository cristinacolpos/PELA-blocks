# Remove dead space from the git repo after filtering out media files

Write-Output "git reflog expire --expire=now --all"
git reflog expire --expire=now --all

Write-Outupt "git gc --prune=now"
git gc --prune=now

Write-Output "Now type: git push --all --force"