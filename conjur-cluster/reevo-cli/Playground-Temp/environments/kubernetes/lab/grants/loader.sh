#!/usr/bin/env bash

technology="kubernetes"
environment="lab"

environments/$technology/$environment/grants/cluster-grants/loader.sh
environments/$technology/$environment/grants/project-grants/loader.sh
environments/$technology/$environment/grants/eso-grants-cluster/loader.sh

#if ls environments/$technology/$environment/grants/*/loader.sh &>/dev/null; then
#    for file in environments/$technology/$environment/grants/*/loader.sh; do
#        echo "Applying $file"
#        bash "$file"
#    done
#fi
