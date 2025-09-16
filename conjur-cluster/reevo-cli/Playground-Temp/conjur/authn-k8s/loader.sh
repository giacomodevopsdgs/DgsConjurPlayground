#!/usr/bin/env bash

conjur policy update -f conjur/authn-k8s/policies.yml -b conjur/authn-k8s

if ls conjur/authn-k8s/*/loader.sh &>/dev/null; then
    for file in conjur/authn-k8s/*/loader.sh; do
        echo "Cluster: Applying $file"
        bash "$file"
    done
fi
