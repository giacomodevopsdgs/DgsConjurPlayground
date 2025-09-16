#!/usr/bin/env bash

vault_name="VAULTDemo"

abs_dir="$(dirname "$(realpath "$0")")"

if ls "$abs_dir"/*.yml &>/dev/null; then
    for file in "$abs_dir"/*.yml; do
        echo "Project grants: Applying $file"
        conjur policy update -f "$file" -b $vault_name
    done
fi