#!/bin/sh -l

cd "$GITHUB_WORKSPACE"
export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

/run-clang-format.py "$@" 2>&1 |tail -n +2 | \
    reviewdog -name=clang-format-lint-action -f=diff -tee \
              -reporter="${INPUT_REPORTER}" \
              -filter-mode="${INPUT_FILTER_MODE}" \
              -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
              -level="${INPUT_LEVEL}" \
              ${INPUT_REVIEWDOG_FLAGS}
