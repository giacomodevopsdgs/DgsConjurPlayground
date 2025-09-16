#!/usr/bin/env bash

cluster_name=$(basename "$(dirname "$0")")

conjur policy update -f conjur/authn-k8s/$cluster_name/body.yml -b conjur/authn-k8s/$cluster_name
