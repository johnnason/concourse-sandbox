#!/bin/sh

cd ci-assets
git --no-pager log -n 1 > ../last-commit-message/last-commit.txt