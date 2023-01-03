#!/bin/sh -l

cd "$GITHUB_WORKSPACE"
export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"
exit_val="0"

/run-clang-format.py "$@" 2>&1 | \
    reviewdog -name="clang-format-lint-action" -f="diff" -tee \
              -reporter="${INPUT_REPORTER}" \
              -filter-mode="${INPUT_FILTER_MODE}" \
              -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
              -level="${INPUT_LEVEL}" \
              ${INPUT_REVIEWDOG_FLAGS} || exit_val="$?"

if [[ "${exit_val}" -ne '0' ]]; then
  exit 1
fi
