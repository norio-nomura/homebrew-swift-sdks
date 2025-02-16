#!/usr/bin/env bash
set -euo pipefail

failed=0
for cask in Casks/*.rb
do
  if ! json=$(brew livecheck --cask --json "${cask}" 2>/dev/null)
  then
    failed=$((failed + 1))
    continue
  fi
  if ! version=$(jq -r '.[0] | if .status then ("::error file='"${cask}"',title=\(.status)::\(.messages|join(", "))\n"|halt_error) end
     | if .version.outdated then .version.latest else empty end' <<<"${json}") 2>&1
  then
    failed=$((failed + 1))
    continue
  fi
  if [[ -n "${version}" ]]
  then
    brew bump-cask-pr --commit --no-audit --version "${version}" --write-only "${cask}"
  fi
done
[[ "${failed}" -eq 0 ]]
