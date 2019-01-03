#!/bin/sh

set -e
sh scripts/run
mv _gitignore .gitignore
git init
git add -A .
git commit -m "Initial Commit"
git tag "v0.0.0"
