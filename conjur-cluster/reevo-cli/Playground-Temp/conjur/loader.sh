#!/usr/bin/env bash

conjur policy load -f conjur/policies.yml -b conjur 

conjur/authn-k8s/loader.sh
conjur/authn-ldap/loader.sh
conjur/seed-generation/loader.sh
