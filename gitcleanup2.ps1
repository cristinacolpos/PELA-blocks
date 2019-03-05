#!/bin/sh -ev
git reflog expire --expire-unreachable=now --all
git gc --prune=now
git push --all --force
git status
