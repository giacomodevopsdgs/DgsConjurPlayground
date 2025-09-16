#!/usr/bin/env bash

branch_eso="eso"
vault_name=" VAULTDemo"

abs_dir="$(dirname "$(realpath "$0")")"

echo "ESO grants: Applying mappings"
conjur policy update -f "$abs_dir/teams.yml" -b $branch_eso

if ls "$abs_dir"/*.yml &>/dev/null; then
    for file in "$abs_dir"/*.yml; do
        nomeCluster=$(basename "$file" .yml)
        [[ "$nomeCluster" == "teams" ]] && continue
        echo "ESO grants: Applying $file"
        conjur policy update -f "$file" -b $vault_name
    done
fi
