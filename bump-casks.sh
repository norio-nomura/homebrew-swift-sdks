#!/usr/bin/env bash
set -euo pipefail

bumped=0
for cask in Casks/*.rb; do
    json=$(brew livecheck --cask --json --quiet "${cask}") || continue
    version=$(jq -er '.[0]|if .version.outdated then .version.latest else empty end' <<< "${json}") || continue
    if [[ -n "${version}" ]]; then
        brew bump-cask-pr --commit --no-audit --quiet --version "${version}" --write-only "${cask}" && bumped=1
        bumped=1
    fi
done
[[ "${bumped}" -eq 1 ]]
