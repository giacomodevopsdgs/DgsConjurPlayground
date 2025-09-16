#!/usr/bin/env bash

technology="service"
vault_name=" VAULTDemo"
environment="$(basename "$(dirname $0)")"

# Respect the order
conjur policy update -f environments/$technology/$environment/hosts.yml -b environments/$technology/$environment
conjur policy update -f environments/$technology/$environment/grants.yml -b $vault_name
