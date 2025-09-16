#!/bin/bash

# Set variables
ACCOUNT="dgs-lab" # Replace with the Conjur Account (from /info)
LB_FQDN="conjur-cluster-temp.lab" # Replace with Load Balancer FQDN

# Login into CONJUR with user ADMIN
conjur init -s --url https://"$LB_FQDN" --account $ACCOUNT
conjur -d login -i admin
