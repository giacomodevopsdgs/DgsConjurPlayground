#!/usr/bin/env bash

# Attention, this script should only be run by the administrator
# Needed after the Synchronizer installation

# Ask for confirmation
echo ""
read -p "Type 'SYNC' to continue: " response
if [ "$response" = "SYNC" ]; then
  echo "Continuing..."
else
  echo "No, aborting..."
  exit 1
fi

conjur policy update -b root -f policies-synchronizer.yml
