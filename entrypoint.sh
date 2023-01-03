#!/bin/sh -l

cd "$GITHUB_WORKSPACE"
export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

/run-clang-format.py "$@" 2>&1 \
    | reviewdog -name="clang-format-lint-action" -filter-mode=file -f=diff -reporter="github-pr-review"
