#!/usr/bin/env bash

technology="kubernetes"
environment="$(basename "$(dirname $0)")"

# Respect the order
echo "Loading PROJECT policies for $environment"
bash environments/$technology/$environment/projects/loader.sh
echo "Loading GRANTS policies for $environment"
bash environments/$technology/$environment/grants/loader.sh
