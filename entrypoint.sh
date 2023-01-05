#!/bin/sh -l

cd "$GITHUB_WORKSPACE"
export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

/run-clang-format.py "$@" 2>&1 |tail -n +2 | \
    reviewdog -name=clang-format-lint-action -f=diff -tee \
              -reporter=github-pr-review \
              -filter-mode=nofilter \
              -fail-on-error=true \
              -level=error \
              ${INPUT_REVIEWDOG_FLAGS}
