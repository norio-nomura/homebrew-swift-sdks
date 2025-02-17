#!/usr/bin/env bash
set -euo pipefail

failed=0
for cask in Casks/*.rb
do
  if ! json=$(brew livecheck --cask --json --verbose "${cask}" 2>/dev/null)
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
    # detect sha256
    original_url="$(jq -r '.[0]|.version as $v|.meta.url.original|gsub($v.current|gsub("\\.";"\\.");$v.latest)' <<<"${json}")"
    case "${original_url}" in
      */swift_releases.yml)
        final_url="$(jq -r '.[0].meta.url.final' <<<"${json}")"
        downloaded_json=$(curl -fsSL "${final_url}"|yq -o=json -)
        sha256=$(jq -r 'reverse|map(.platforms|.[]|select(.platform == "static-sdk"))|first|.checksum' <<<"${downloaded_json}")
        ;;
      */static_sdk.yml)
        final_url="$(jq -r '.[0].meta.url.final' <<<"${json}")"
        regex="$(jq -r '.[0].meta.regex|sub("^/(?<x>.*)/$";.x)|gsub("\\\\";"\\\\")' <<<"${json}")"
        downloaded_json=$(curl -fsSL "${final_url}"|yq -o=json -)
        sha256=$(jq -r 'map(select(.dir|test("'"${regex}"'")))|first|.checksum' <<<"${downloaded_json}")
        ;;
      *//github.com/*.artifactbundle.zip)
        sha256=$(curl -fsSL "${original_url}.sha256" -o -)
        ;;
      *) ;;
    esac
    brew bump-cask-pr --commit --no-audit ${sha256:+--sha256 ${sha256}} --version "${version}" --write-only "${cask}"
  fi
done
[[ "${failed}" -eq 0 ]]
