#!/bin/sh

# TODO: paramaterize repos
git clone ci-changelog ci-changelog-update
cd ci-changelog-update

# TODO: paramaterize file inputs
cat ../last-commit-message/last-commit.txt | cat - README.md > temp && mv temp README.md
git add README.md
git config --local user.email $GIT_EMAIL
git config --local user.name $GIT_USER
git commit -m "Updating Changelog"