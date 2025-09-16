#!/usr/bin/env bash

# Attention, this script should only be run by the administrator
# Sensitive actions are taking (HIGH RISK OPERATION)

# Ask for confirmation
echo ""
read -p "Type 'Yes' to continue: " response
if [ "$response" = "Yes" ]; then
  echo "Continuing..."
else
  echo "No, aborting..."
  exit 1
fi

awk 'FNR==1 && NR!=1 {print ""} {print}' groups.yml policies.yml grants.yml permits.yml users.yml > root.yml

conjur policy update -b root -f root.yml

conjur/cluster/loader.sh

rm root.yml
