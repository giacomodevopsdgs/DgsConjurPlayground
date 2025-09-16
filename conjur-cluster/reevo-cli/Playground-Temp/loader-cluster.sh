#!/usr/bin/env bash

# Verify user
whoami=$(conjur whoami)
username=$(echo "$whoami" | jq -r '.username')
if [ "$username" = "admin" ]; then
  echo "Error, the admin user should not perform this action!"
  exit 1
fi

# Run loaders
conjur/loader.sh