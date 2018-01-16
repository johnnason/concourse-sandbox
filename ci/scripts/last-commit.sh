#!/bin/sh

cd ci-assets
# TODO: paramaterize file output
git --no-pager log -n 1 > ../last-commit-message/last-commit.txt