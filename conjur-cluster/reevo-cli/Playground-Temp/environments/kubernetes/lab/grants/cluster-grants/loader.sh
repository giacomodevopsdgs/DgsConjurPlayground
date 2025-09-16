#!/usr/bin/env bash

abs_dir="$(dirname "$(realpath "$0")")"

if ls "$abs_dir"/*.yml &>/dev/null; then
    for file in "$abs_dir"/*.yml; do
        echo "Cluster grants: Applying $file"
        cluster_name="$(basename "$file" .yml)"
        conjur policy update -f "$file" -b conjur/authn-k8s/$cluster_name
    done
fi
