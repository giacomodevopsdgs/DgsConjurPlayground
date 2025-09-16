#!/usr/bin/env bash

environments=("lab")

# Verify user
whoami=$(conjur whoami)
username=$(echo "$whoami" | jq -r '.username')
if [ "$username" = "admin" ]; then
  echo "Error, the admin user should not perform this action!"
  exit 1
fi

# Run loaders
for env in "${environments[@]}"; do
    if ls environments/*/"$env"/loader.sh &>/dev/null; then
        for file in environments/*/"$env"/loader.sh; do
            echo "Applying $file"
            bash "$file"
        done
    else
        echo -e "\nCannot proceed as no environments exist from the list:"
        for env in "${environments[@]}"; do echo "- $env"; done
    fi
done
