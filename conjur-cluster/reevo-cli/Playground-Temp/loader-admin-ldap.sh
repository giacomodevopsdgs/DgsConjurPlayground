#!/usr/bin/env bash

# Attention, this script should only be run by the administrator
# Sensitive actions are taking (HIGH RISK OPERATION)

# Ask for confirmation
echo ""
read -p "Type 'LDAP' to continue: " response
if [ "$response" = "LDAP" ]; then
  echo "Continuing..."
else
  echo "No, aborting..."
  exit 1
fi

conjur policy update -b root -f ldap-base-policy.yml

conjur/authn-ldap/loader.sh

conjur policy update -b root -f ldap.yml
