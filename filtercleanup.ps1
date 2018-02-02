# Unless you are maintaining a git repo of models, you do not need this script
#
# Finish removing dead space from the git repo after filtering out media files
# Run this _after_ filterstl.ps1 and filterpng.ps1

Write-Output "git reflog expire --expire=now --all"
git reflog expire --expire=now --all

Write-Output "git gc --prune=now"
git gc --prune=now

Write-Output "Now type: git push --all --force"