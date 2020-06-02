#!/usr/bin/env bash


if [[ -n "$(git status --porcelain)" ]]; then git add .; git commit -m auto; fi

git fetch

if [[ "$(git rev-parse HEAD)" == "$(git rev-parse origin/master)" ]];
then
    git rebase origin/master; git push origin HEAD:master
fi
