#!/bin/sh

cd ci-assets
# TODO: paramaterize file output
# Format: <name>: <commit hash>, <time> \n <message>
git --no-pager log -n 1 --format="# %an: %H, %ai%n%n> %s%n" > ../last-commit-message/last-commit.txt