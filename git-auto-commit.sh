#!/usr/bin/env bash

# cmd /c ""C:\Program Files\Git\bin\bash.exe" --login -i -- C:\Users\123\Desktop\note\git-auto-commit.sh"

# win10 click whether login to run it. imp

cd "$(dirname "$0")"

if [[ -n "$(git status --porcelain)" ]]; then git add .; git commit -m auto; fi

git fetch

if [[ "$(git rev-parse HEAD)" != "$(git rev-parse origin/master)" ]];
then
    git rebase origin/master; git push origin HEAD:master
fi

